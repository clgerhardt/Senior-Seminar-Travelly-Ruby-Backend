class AddExpenseReportToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_reference :documents, :expense_report, foreign_key: true
  end
end
