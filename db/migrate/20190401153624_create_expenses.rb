class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :expense_type
      t.decimal :amount
      t.references :expensed, polymorphic: true, index: true
      t.timestamps
    end
  end
end
