class ExpenseCoveragesController < ApplicationController
  before_action :set_expense_coverage, only: [:show, :update, :destroy]

  # GET /expense_coverages
  def index
    respond_with ExpenseCoverage.all
  end

  # GET /expense_coverages/1
  def show
    respond_with ExpenseCoverage.find(params["id"])
  end

  # POST /expense_coverages
  def create
    respond_with ExpenseCoverage.create(expense_coverage_params)
  end

  # PATCH/PUT /expense_coverages/1
  def update
    expense_coverage = ExpenseCoverage.find(params["id"])
    expense_coverage.update_attributed(expense_coverage_params)
    respond_with expense_coverage, json: expense_coverage
  end

  # DELETE /expense_coverages/1
  def destroy
    @expense_coverage.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_coverage
      @expense_coverage = ExpenseCoverage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_coverage_params
      params.require(:expense_coverage).permit(:id, :amount, :expense_id)
    end
end
