class AddBudgetToDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :budget, :float
  end
end
