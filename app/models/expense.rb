class Expense < ApplicationRecord
    validates :expense_type, :expensed_type, :expensed_id, presence: true
    validates :expensed_id, numericality: true
    belongs_to :expensed, polymorphic: true
    has_many :expense_coverages
end
