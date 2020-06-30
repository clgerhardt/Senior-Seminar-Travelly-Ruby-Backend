class Travel < ApplicationRecord
    validates :destination, :purpose, :date_of_departure,
    :date_of_return, :employee_id, presence: true
    validates :employee_id, numericality: true
    validates :date_of_departure, timeliness: {on_or_after: lambda {Date.current}, type: :date}
    validates :date_of_return, timeliness: {on_or_after: :date_of_departure}
    has_many :expenses, as: :expensed
    has_many :approvements, dependent: :destroy
    has_one :expense_report, dependent: :destroy
    has_many :comments, as: :commented
    def total_price
      expenses.to_a.sum{

        |expense| expense.amount

      }
    end

    def update_status
      count = 0
      self.update_attributes(:status => 3)
      approvements.each do |approvement|
        if approvement.approved_tf == false
          self.update_attributes(:status => 2)
          break
        end

        if approvement.approved_tf == true
          count += 1
        end
      end
      if self.status == 2
        approvements.each do |approvement|
          approvement.update_attributes(:approved_tf => false)
        end
      end
      if count == approvements.length
        self.update_attributes(:status => 1)
      end
    end
end
