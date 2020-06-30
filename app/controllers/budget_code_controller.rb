class BudgetCodeController < ApplicationController

    def index
      respond_with BudgetCode.all
    end

    def show
      respond_with BudgetCode.find(params[:id])
    end

    def create
      respond_with BudgetCode.create(budget_code_params)
    end

    def update
      budget_code = BudgetCode.find(params["id"])
      budget_code.update_attributes(budget_code_params)
      respond_with budget_code, json: budget_code
    end

    def destroy
      respond_with BudgetCode.destroy(params[:id])
    end

    private
    def budget_code_params
      params.require(:budget_code).permit(:id, :budget_code, :description, :department_id)
    end

  end
