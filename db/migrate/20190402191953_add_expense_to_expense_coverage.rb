class AddExpenseToExpenseCoverage < ActiveRecord::Migration[5.2]
  def change
    add_reference :expense_coverages, :expense, foreign_key: true
  end
end
