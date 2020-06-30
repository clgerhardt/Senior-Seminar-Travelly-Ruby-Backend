class BudgetCode < ApplicationRecord
    validates :budget_code, presence: {message: "Budget code must be given."}
    validates :description, presence: {message: "A Description is needed."}
    validates :department_id, presence: {message: "Department ID must be given."}
    validates :budget_code, numericality: {message: "Budget code must be a number."}

    has_one :department, dependent: :destroy
    has_many :approvements, dependent: :destroy
end
