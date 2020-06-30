class EmployeesController < ApplicationController

  def index
    @role = Role.find(@current_user.role_id)
    if @role.role == 'Employee'
      respond_with @current_user
    elsif @role.role == 'Budget Approver'
      emps_list = Employee.where(department_id: @current_user.department_id)
      respond_with emps_list
    else
      respond_with Employee.all
    end
  end

  def show
    respond_with Employee.find(params[:id])
  end

  def create
    respond_with Employee.create(employee_params)
  end

  def update
    employee = Employee.find(params["id"])
    employee.update_attributes(employee_params)
    respond_with employee, json: employee
  end

  def destroy
    respond_with Employee.destroy(params[:id])
  end

  def travel_forms
    @travels = Travel.all
    travels_for_employee = []
   
    @travels.each do |travel|

      if travel.employee_id == @current_user.id


        if ExpenseReport.find_by_travel_id(travel.id).nil?
          json = {
            "id": travel.id,
            "destination": travel.destination,
            "purpose": travel.purpose,
            "date_of_departure": travel.date_of_departure,
            "date_of_return": travel.date_of_return,
            "created_at": travel.created_at,
            "updated_at": travel.updated_at,
            "employee_id": @current_user.id,
            "status": travel.status,
            "status_er": nil,
            "approved_final": nil
          }
        else 
          json = {
            "id": travel.id,
            "destination": travel.destination,
            "purpose": travel.purpose,
            "date_of_departure": travel.date_of_departure,
            "date_of_return": travel.date_of_return,
            "created_at": travel.created_at,
            "updated_at": travel.updated_at,
            "employee_id": @current_user.id,
            "status": travel.status,
            "status_er": ExpenseReport.find_by_travel_id(travel.id).status_er,
            "approved_final": ExpenseReport.find_by_travel_id( travel.id).approved_final
          }
        
        end

          
        travels_for_employee << json

      end
      puts travels_for_employee
    end
    respond_with travels_for_employee, json: travels_for_employee
  end

  def approvements_list
    # @employee = Employee.find(params[:employee_id])

    @role = Role.find(@current_user.role_id)

    if @role.role == "Payment Approver"

      travel_forms = []

      @travel_list = Travel.all

      @travel_list.each do |travel|
        approvements = []

        @approvement_list = Approvement.where({travel_id: travel.id })

        @approvement_list.each do |approvement|

          @budget_code = BudgetCode.find(approvement.budget_code_id)

          # if @budget_code.department_id == @employee.department_id
          @dept = Department.find(@budget_code.department_id)
            json = {
              "approvement_id": approvement.id,
              "department_name": @dept.name,
              "budget_code": @budget_code.budget_code,
              "approved_tf": approvement.approved_tf,
              "approved_er": approvement.approved_er
            }
            approvements << json

          # end
        end

        if approvements.length > 0
          @exp_r = ExpenseReport.find_by_travel_id(travel.id)
          @emp = Employee.find(travel.employee_id)
          if @exp_r.nil?
            @emp = Employee.find(travel.employee_id)
            json = {
              "travel_id": travel.id,
              "purpose": travel.purpose,
              "destination": travel.destination,
              "leaveDate": travel.date_of_departure,
              "returnDate": travel.date_of_return,
              "employee_id": @emp.id,
              "employee_first_name": @emp.first_name,
              "employee_last_name": @emp.last_name,
              "status": travel.status,
              "approved": approvements
            }
          else
            @emp = Employee.find(travel.employee_id)
            json = {
              "travel_id": travel.id,
              "expense_report_id": @exp_r.id,
              "expense_report_status": @exp_r.status_er,
              "approved_final": @exp_r.approved_final,
              "purpose": travel.purpose,
              "destination": travel.destination,
              "leaveDate": travel.date_of_departure,
              "returnDate": travel.date_of_return,
              "employee_id": @emp.id,
              "employee_first_name": @emp.first_name,
              "employee_last_name": @emp.last_name,
              "status": travel.status,
              "approved": approvements
            }
          end


          travel_forms << json
        end
        end

      end

      if @role.role == "Budget Approver"
        travel_forms = []
        @travel_list = Travel.all
        @travel_list.each do |travel|

          # @emp_obj = Employee.find(travel.employee_id)

          # if @employee.department_id == @emp_obj.department_id

            # approvements = []
            pre_approvements = []
            add = false
            @approvement_list = Approvement.where({travel_id: travel.id })

            @approvement_list.each do |approvement|

              @budget_code = BudgetCode.find(approvement.budget_code_id)

              # if @budget_code.department_id == @employee.department_id
                @dept = Department.find(@budget_code.department_id)
                  json = {
                    "approvement_id": approvement.id,
                    "department_name": @dept.name,
                    "budget_code": @budget_code.budget_code,
                    "approved_tf": approvement.approved_tf,
                    "approved_er": approvement.approved_er                 }
                  pre_approvements << json

                # end

              end

            @approvement_list.each do |approvement|

              @budget_code = BudgetCode.find(approvement.budget_code_id)

              if @budget_code.department_id == @current_user.department_id
                # @dept = Department.find(@budget_code.department_id)
                #   json = {
                #     "approvement_id": approvement.id,
                #     "department_name": @dept.name,
                #     "budget_code": @budget_code.budget_code,
                #     "approved_tf": approvement.approved_tf,
                #   }
                #   approvements << json

                add = true

                end

              end


              if add == true
                @exp_r = ExpenseReport.find_by_travel_id(travel.id)
                if @exp_r.nil?
                  @emp = Employee.find(travel.employee_id)
                  json = {
                    "travel_id": travel.id,
                    "purpose": travel.purpose,
                    "destination": travel.destination,
                    "leaveDate": travel.date_of_departure,
                    "returnDate": travel.date_of_return,
                    "employee_id": @emp.id,
                    "employee_first_name": @emp.first_name,
                    "employee_last_name": @emp.last_name,
                    "status": travel.status,
                    "approved": pre_approvements
                  }
                else
                  @emp = Employee.find(travel.employee_id)
                  json = {
                    "travel_id": travel.id,
                    "expense_report_id": @exp_r.id,
                    "expense_report_status": @exp_r.status_er,
                    "approved_final": @exp_r.approved_final,
                    "purpose": travel.purpose,
                    "destination": travel.destination,
                    "leaveDate": travel.date_of_departure,
                    "returnDate": travel.date_of_return,
                    "employee_id": @emp.id,
                    "employee_first_name": @emp.first_name,
                    "employee_last_name": @emp.last_name,
                    "status": travel.status,
                    "approved": pre_approvements
                  }
                end

                travel_forms << json
              end

            # if approvements.length > 0

            #   @emp = Employee.find(travel.employee_id)
            #   json = {

            #     "travel_id": travel.id,
            #     "purpose": travel.purpose,
            #     "destination": travel.destination,
            #     "leaveDate": travel.date_of_departure,
            #     "returnDate": travel.date_of_return,
            #     "employee_id": @emp.id,
            #     "employee_first_name": @emp.first_name,
            #     "employee_last_name": @emp.last_name,
            #     "status": travel.status,
            #     "approved": approvements
            #   }

            #   travel_forms << json
            # end

            # end

          end

        end
      respond_with travel_forms, json: travel_forms
    end

  private
  def employee_params
    params.require(:employee).permit(:id, :first_name, :last_name, :role_id, :department_id, :email, :password)
  end

end
