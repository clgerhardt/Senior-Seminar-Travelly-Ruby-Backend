class ExpenseCoverage < ApplicationRecord
  validates :amount, :expense_id, :budget_code_id, presence: true, numericality: true
end
