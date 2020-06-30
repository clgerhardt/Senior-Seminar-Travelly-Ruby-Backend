class Approvement < ApplicationRecord
    validates :budget_code_id, :travel_id, :amount, presence: true
    validates :travel, :presence => true
    validates :amount, numericality: true
    has_one :budget_code
    belongs_to :budget_approver, :class_name => 'Employee', optional: true
    belongs_to :travel
end