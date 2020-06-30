class AddBudgetCodeToExpenseCoverage < ActiveRecord::Migration[5.2]
  def change
    add_reference :expense_coverages, :budget_code, foreign_key: true
  end
end
