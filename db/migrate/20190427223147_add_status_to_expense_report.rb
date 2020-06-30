class AddStatusToExpenseReport < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_reports, :status_er, :boolean
  end
end
