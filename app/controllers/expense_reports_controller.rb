class ExpenseReportsController < ApplicationController
  # before_action :set_expense_report, only: [:show, :update, :destroy]

  # GET /expense_reports
  def index
    respond_with ExpenseReport.all
  end

  # GET /expense_reports/1
  def show
    expense_report = ExpenseReport.find(params["id"])
    expenses = Expense.where(expensed_id: expense_report.id, expensed_type: "ExpenseReport")
    expense_list = []
    @travel = Travel.find(expense_report.travel_id)
    expenses.each do |expense|
      coverages = ExpenseCoverage.where(expense_id: expense.id)

      entries = []
      coverages.each do |coverage|

        @budget_code = BudgetCode.find(coverage.budget_code_id)
        @department = Department.find(@budget_code.department_id)
        approved_er = Approvement.where(travel_id: @travel.id, budget_code_id: @budget_code.id ).first.approved_er
        approvement_id = Approvement.where(travel_id: @travel.id, budget_code_id: @budget_code.id ).first.id

        entries_json = {
          "amount": coverage.amount,
          "department_name": @department.name,
          "budgetCode": @budget_code.budget_code,
          "entry_id": coverage.id,
          "department": @department.id,
          "approved_er": approved_er,
          "approvement_id":  approvement_id
        }

        entries << entries_json

      end

      expense_json = {
        expense_id: expense.id,
        expenseType: expense.expense_type,
        expenseDesc: expense.description,
        expenseDate: expense.date,
        entries: entries
      }

      expense_list << expense_json
    end

    images = Document.where(expense_report_id: expense_report.id)
    puts images
    image_urls = []

    images.each do |image|
      image_urls << image.image_url
    end

    comments_list = Comments.where(commented_id: expense_report.id, commented_type: "ExpenseReport")

      puts comments_list
      comments_list_to_send = []
      comments_list.each do |comment|


        employee = Employee.find(comment.employee_id)
        department_name = Department.find(employee.department_id).name
        # approvements = Approvement.find_by_travel_id(travel.id)

        json = {
          "department": department_name,
          "comment": comment.comment,
          "name": employee.first_name + " " + employee.last_name,
          "date": comment.created_at
        }
        comments_list_to_send << json
      end

    json = {
      expense_report_id: expense_report["id"],
      travel_id: expense_report["travel_id"],
      total_price: expense_report.total_price,
      status: expense_report.status_er,
      expenses: expense_list,
      images: image_urls,
      comments: comments_list_to_send,
      approved_final: expense_report.approved_final
    }

    respond_with json
  end

  # POST /expense_reports
  def create
    json_input = params
    json = json_input.to_json
    json = JSON.parse(json)

    expenses = json["expenses"]


    expense_report = ExpenseReport.create(expense_report_params)

    expenses.each do |expense|
      expense_entries = expense["entries"]

      expense_params = {expense_type: expense["expenseType"],
                              expensed_type: "ExpenseReport",
                              description: expense["expenseDesc"],
                              date: expense["expenseDate"],
                              expensed_id: expense_report.id}

      expense_obj = Expense.create(expense_params)

      expense_entries.each do |expense_entry|

        expense_coverage_params = {amount:expense_entry["amount"],
                                  expense_id: expense_obj.id,
                                  budget_code_id: BudgetCode.find_by_budget_code(expense_entry["budgetCode"]).id}

        expense_coverage = ExpenseCoverage.create(expense_coverage_params)

      end

    end


    respond_with expense_report, json: expense_report
  end

  # PATCH/PUT /expense_reports/1
  def update
    json_input = params
    json = json_input.to_json
    json = JSON.parse(json)

    #expense_coverages = json["expense_coverages"]


    expenses = json["expenses"]

    expense_report = ExpenseReport.find(json["expense_report_id"])
    @travel = Travel.find(expense_report.travel_id)
    expense_report.update_attributes(:approved_final => nil, :payment_mgr_id => nil)
    @approvements = Approvement.where(travel_id: @travel.id)
    @approvements.each do |approvement|

      approvement.update_attributes(:approved_er => nil)

    end

    expense_report.update_status

    expenses.each do |expense|
      expense_obj = nil
      if Expense.exists?(id: expense["expense_id"])

        @expense_to_update = Expense.find(expense["expense_id"])
        @expense_to_update.update_attributes(:expense_type => expense["expenseType"],
         :expensed_type => "ExpenseReport", :description => expense["expenseDesc"],
         :date => expense["expenseDate"]
         )
         expense_obj = @expense_to_update

      else
        expense_params = {
          expense_type: expense["expenseType"],
          expensed_type: "ExpenseReport",
          expensed_id: expense_report.id,
          description: expense["expenseDesc"],
          date: expense["expenseDate"],
        }
        expense_obj = Expense.create(expense_params)
      end

      expense_entries = expense["entries"]

      expense_entries.each do |expense_entry|

        if ExpenseCoverage.exists?(id: expense_entry["entry_id"])

          @expense_coverage_update = ExpenseCoverage.find(expense_entry["entry_id"])
          @expense_coverage_update.update_attributes(
            :amount => expense_entry["amount"],
            :budget_code_id => BudgetCode.find_by_budget_code(expense_entry["budgetCode"]).id
          )

        else
          expense_coverage_params = {amount: expense_entry["amount"],
            expense_id: expense_obj.id,
            budget_code_id: BudgetCode.find_by_budget_code(expense_entry["budgetCode"]).id}
          expense_coverage = ExpenseCoverage.create(expense_coverage_params)

        end

      end

    end
    respond_with expense_report, json: expense_report
  end

  # DELETE /expense_reports/1
  def destroy
    respond_with ExpenseReport.destroy(params["id"])
  end

  def final_approval
    @expense_report = ExpenseReport.find(params["id"])

    if expense_report_params["approved_final"] == true && @expense_report.approved_final == true
      json_val = {"error": "This travel report has already been approved"}
      respond_with json_val, json: json_val

    else
      comment = expense_report_params["comment"]
      commenter = expense_report_params["commenter_id"]
      new_comment = Comments.create(comment: comment, commented_id: ExpenseReport.find(@expense_report.id).id, commented_type: "ExpenseReport", employee_id: commenter)
      @expense_report.update_attributes(expense_report_params.except(:comment, :commenter_id))
      @expense_report.update_status
      if(@expense_report.approved_final == true)
        expenses = Expense.where(expensed_type: "ExpenseReport", expensed_id: @expense_report.id)
        expenses.each do |expense|
          @coverages = ExpenseCoverage.where(expense_id: expense.id)
          @coverages.each do |coverage|
            @budgetcode = BudgetCode.find(coverage.budget_code_id)
            @department = Department.find(@budgetcode.department_id)
            @department.deduct_from_budget(coverage.amount)
          end

        end
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_expense_report
    #   @expense_report = ExpenseReport.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def expense_report_params
      params.require(:expense_report).permit(:id, :travel_id, :status_er, :approved_final, :payment_mgr_id, :comment, :commenter_id)
    end
end
