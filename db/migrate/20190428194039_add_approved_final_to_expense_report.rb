class AddApprovedFinalToExpenseReport < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_reports, :approved_final, :boolean
  end
end
