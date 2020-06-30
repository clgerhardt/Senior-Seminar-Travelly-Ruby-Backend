class Department < ApplicationRecord
    validates :name, :department_number, :budget, presence: true
    validates :department_number, :budget, numericality: true
    has_many :employees, dependent: :destroy
    has_many :budget_codes, dependent: :destroy

    def deduct_from_budget(amount)
      newBudget = self.budget
      newBudget = newBudget - amount
      self.update_attributes(budget: newBudget)
    end
end
