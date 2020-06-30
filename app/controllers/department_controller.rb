class DepartmentController < ApplicationController

    def index
      respond_with Department.all
    end
  
    def show
      respond_with Department.find(params[:id])
    end
  
    def create
      respond_with Department.create(department_params)
    end
  
    def update
      department = Department.find(params["id"])
      department.update_attributes(department_params)
      respond_with department, json: department
    end
  
    def destroy
      respond_with Department.destroy(params[:id])
    end
  
    private
    def department_params
      params.require(:department).permit(:id, :name, :department_number, :budget)
    end
  
  end
  