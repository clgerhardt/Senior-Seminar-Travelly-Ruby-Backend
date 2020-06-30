class AddPaymentMgrToExpenseReport < ActiveRecord::Migration[5.2]
  def change
    add_reference :expense_reports, :payment_mgr
  end
end
