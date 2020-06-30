class AddTravelToExpenseReport < ActiveRecord::Migration[5.2]
  def change
    add_reference :expense_reports, :travel, foreign_key: true
  end
end
