class Role < ApplicationRecord
    validates :role, :description, presence: true
    has_many :employees
end
