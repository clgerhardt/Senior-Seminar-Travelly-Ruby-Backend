class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :update, :destroy]

  # GET /expenses
  def index
    respond_with Expense.all
  end

  # GET /expenses/1
  def show
    respond_with Expense.find(params[:id])
  end

  # POST /expenses
  def create
    puts expense_params
    respond_with Expense.create(expense_params)
  end

  # PATCH/PUT /expenses/1
  def update
    expense = Expense.find(params["id"])
    expense.update_attributes(expense_params)
    respond_with expense, json: expense
  end

  # DELETE /expenses/1
  def destroy
    @expense.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_params
      params.require(:expense).permit(:expense_type, :amount, :expensed_type, :expensed_id, :description, :date)
    end
end
