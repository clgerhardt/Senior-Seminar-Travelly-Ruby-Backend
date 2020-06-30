class AddBudgetCodesToApprovement < ActiveRecord::Migration[5.2]
  def change
    add_reference :approvements, :budget_code, foreign_key: true
  end
end
