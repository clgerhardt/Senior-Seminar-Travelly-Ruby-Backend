class CreateExpenseReports < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_reports do |t|

      t.timestamps
    end
  end
end
