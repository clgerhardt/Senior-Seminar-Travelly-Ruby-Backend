class ApprovementController < ApplicationController
    def index
      respond_with Approvement.all
    end

    def show
      respond_with Approvement.find(params[:id])
    end

    def create
      approvement = Approvement.create(approvement_params)

      @travel = Travel.find(approvement.travel_id)
      @travel.update_status

      respond_with approvement
    end

    def update
      approvement = Approvement.find(params["id"])

      # puts approvement_params
      comment = approvement_params["comment"]
      commenter = approvement_params["commenter_id"]
      if approvement_params.key?("approved_er")
        new_comment = Comments.create(comment: comment, commented_id: ExpenseReport.find_by_travel_id(Travel.find(approvement.travel_id).id).id, commented_type: "ExpenseReport", employee_id: commenter)
      else
        new_comment = Comments.create(comment: comment, commented_id: Travel.find(approvement.travel_id).id, commented_type: "Travel", employee_id: commenter)
      end

      approvement.update_attributes(approvement_params.except(:comment, :commenter_id))

      @travel = Travel.find(approvement.travel_id)
      @expense_report = ExpenseReport.find_by_travel_id(@travel.id)

      @travel.update_status
      if @expense_report.nil?
       puts "im nil bithes"
      else 
        @expense_report.update_status
        @expense_report.update_other_approvements
      end

      respond_with approvement, json: approvement
    end

    def destroy
      respond_with Approvement.destroy(params[:id])
    end

    # def comments_list

    #   @travel_id = params[:travel_id]

    #   @approvements = Approvement.where(travel_id: @travel_id)
    #   puts @approvements

    #   all_comments = []
    #   @approvements.each do |approvement|

    #     @comments = Comments.where(approvement_id: approvement.id)

    #     @comments.each do |comment|

    #       budget_code = BudgetCode.find(approvement.budget_code_id)
    #       department_name = Department.find(budget_code.department_id).name
    #       employee = Employee.find(comment.employee_id)
    #       json = {
    #         "department_name": department_name,
    #         "comment": comment.comment,
    #         "budget_code": budget_code.budget_code,
    #         "amount": approvement.amount,
    #         "name": employee.first_name + " " + employee.last_name,
    #       }

    #       all_comments << json
    #     end

    #   end

    #   respond_with all_comments, json: all_comments

    # end

    private
    def approvement_params
      params.require(:approvement).permit(:id, :approved_tf, :date_budget_app, :date_payment_mgr, :budget_code_id, :budget_approver_id, :approved_er, :travel_id, :amount, :comment, :commenter_id)
    end

  end
