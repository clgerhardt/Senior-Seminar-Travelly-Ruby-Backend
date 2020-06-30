class CreateExpenseCoverages < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_coverages do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
