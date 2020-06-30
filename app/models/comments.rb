class Comments < ApplicationRecord
    validates :commented_id,:commented_type, :comment, presence: true
	belongs_to :commented, polymorphic: true
    has_one :employee
end
