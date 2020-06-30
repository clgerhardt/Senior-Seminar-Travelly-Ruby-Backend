class AddDepartmentToBudgetCode < ActiveRecord::Migration[5.2]
  def change
    add_reference :budget_codes, :department, foreign_key: true
  end
end
