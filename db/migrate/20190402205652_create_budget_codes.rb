class CreateBudgetCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_codes do |t|
      t.integer :budget_code
      t.string :description

      t.timestamps
    end
  end
end
