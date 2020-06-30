class TravelController < ApplicationController

    def index
        respond_with Travel.all
    end

    def show
      travel = Travel.find(params["id"])
      travel.update_status

      comments_list = Comments.where(commented_id: travel.id, commented_type: "Travel")

      puts comments_list
      comments_list_to_send = []
      comments_list.each do |comment|

        
        employee = Employee.find(comment.employee_id)
        department_name = Department.find(employee.department_id).name
        approvements = Approvement.find_by_travel_id(travel.id)

        json = {
          "department": department_name,
          "comment": comment.comment,
          "name": employee.first_name + " " + employee.last_name,
          "date": comment.created_at
        }
        comments_list_to_send << json
      end

      json = {travel: travel["id"],
        destination: travel["destination"],
        purpose: travel["purpose"],
        departure: travel["date_of_departure"],
        return: travel["date_of_return"],
        total: Travel.find(params["id"]).total_price,
        status: travel.status,
        comments: comments_list_to_send}

      respond_with json
    end

    def create
        json_input = params
        json = json_input.to_json
        json = JSON.parse(json)['values']
        budgetSources = json["budgetSources"]
        travel_params = {destination: json["destination"],
                         date_of_departure: json["leaveDate"],
                         date_of_return: json["returnDate"],
                         employee_id: json["employeeId"],
                         purpose: json["purpose"]}
        @travel = Travel.create(travel_params)
        travel_id = @travel.id
        expenses = json["itemizedExpenses"]
        expenses.each do |expense|
            expense_params = {expense_type: expense["expenseDesc"],
                              amount: expense["amount"],
                              expensed_type: "Travel",
                              expensed_id: travel_id}
          expense_obj = Expense.create(expense_params)
        end
        budgetSources.each do |approvement|
            approvement_params = {budget_code_id: (BudgetCode.find_by_budget_code(approvement["budgetCode"])).id,
                                  travel_id: travel_id, amount: approvement["amount"]}
            approvement_obj = Approvement.create(approvement_params)
        end

        respond_with @travel, json: @travel
    end

    def destroy
    respond_with Travel.destroy(params[:id])
    end

    def update
      json_input = params
      json = json_input.to_json
      json = JSON.parse(json)['values']

      @travel = Travel.find(params["id"])
      @travel.update_attributes(:purpose => json["purpose"], :date_of_departure => json["leaveDate"],
                                :date_of_return => json["returnDate"])
      travel_id = @travel.id
      expenses = json["itemizedExpenses"]
      approvements = json["budgetSources"]

      expenses.each do |expense|
        if Expense.exists?(id: expense["id"])
          @expense_to_update = Expense.find(expense["id"])
          @expense_to_update.update_attributes(:expense_type => expense["expenseDesc"],
            :amount => expense["amount"])
        else
          expense_params = {expense_type: expense["expenseDesc"],
                            amount: expense["amount"],
                            expensed_type: "Travel",
                            expensed_id: travel_id}
          expense_obj = Expense.create(expense_params)
        end

      end
      approvements.each do |approvement|
        if Approvement.exists?(id: approvement["id"])
          @approvement_to_update = Approvement.find(approvement["id"])
          @approvement_to_update.update_attributes(:budget_code_id => BudgetCode.find_by_budget_code(approvement["budgetCode"]).id,
              :amount => approvement["amount"], :approved_tf => nil)
        else
          approvement_params = {budget_code_id: (BudgetCode.find_by_budget_code(approvement["budgetCode"])).id,
                                travel_id: travel_id, amount: approvement["amount"]}
          approvement_obj = Approvement.create(approvement_params)
        end
      end
      @travel.update_status
      respond_with @travel, json: @travel
    end

    def expense_report
        @travel = Travel.find(params[:travel_id])

        expenses = Expense.where(expensed_id: @travel.id, expensed_type: "Travel")

        itemizedExpenses = []
        budgetSources = []
        expenses.each do |expense|
          itemizedExpenses << {id: expense.id, expenseDesc: expense.expense_type, amount: expense.amount}
        end
        approvements = Approvement.where(travel_id: params[:travel_id])
        approvements.each do |approvement|
          budgetCode = BudgetCode.find_by_id(approvement.budget_code_id)
          department = Department.find_by_id(budgetCode.department_id)
          budgetSources << {
                      id: approvement.id,
                      department: department.name,
                      department_id: department.id,
                      budgetCode: budgetCode.budget_code,
                      amount: approvement.amount}
        end
        values ={values: {destination: @travel.destination,
                    purpose: @travel.purpose,
                    leaveDate: @travel.date_of_departure,
                    returnDate: @travel.date_of_return,
                    status: @travel.status,
                    itemizedExpenses: itemizedExpenses,
                    budgetSources: budgetSources
                    }
                  }
        respond_with values, json: values
    end

    private
    def travel_params
    params.require(:travel).permit(:id, :destination, :purpose, :date_of_departure, :date_of_return, :employee_id)
    end
end
