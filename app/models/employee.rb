class Employee < ApplicationRecord
    validates :first_name, :last_name, :role_id,
    :department_id, :email, :password_digest,
    presence: true

    has_one :role
    has_many :budget_approver_approvements, :class_name => 'Approvement', :foreign_key => 'budget_approver_id'
    has_many :payment_mgr_expense_reports, :class_name => 'ExpenseReport', :foreign_key => 'payment_mgr_id'
    has_many :comments, dependent: :destroy
    has_secure_password
    validates :email, presence: true, uniqueness: true
end
