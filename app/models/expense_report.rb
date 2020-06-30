class ExpenseReport < ApplicationRecord
  validates :travel_id, presence: true, numericality: true
  validates :travel, :presence => true
  has_many :expenses, as: :expensed
  has_many :documents
  belongs_to :travel
  belongs_to :payment_mgr, :class_name => 'Employee', optional: true
  has_many :comments, as: :commented

  def total_price
    total = 0
    expenses.each do |expense|
      @coverages = expense.expense_coverages
      @coverages.each do |coverage|
        total += coverage.amount 
      end
    end
    
    return total
  end
  
  def update_status
    count = 0
    self.update_attributes(:status_er => nil)
    approvements = travel.approvements

    if(self.approved_final == false)
      approvements.each do |approvement|
        approvement.update_attributes(:approved_er => false)
      end
      self.update_attributes(:status_er => false)
    end

    approvements.each do |approvement|
      if approvement.approved_er == false
        self.update_attributes(:status_er => false)
        break
      end

      if approvement.approved_er == true
        count += 1
      end
    end
    if self.status_er == false
      approvements.each do |approvement|
        approvement.update_attributes(:approved_er => false)
      end
    end
    if count == approvements.length
      self.update_attributes(:status_er => true)
    end
  end

  def update_other_approvements

   flag = true
   expenses.each do |expense|
    @coverages = expense.expense_coverages
    @coverages.each do |coverage|
      @approvements = Approvement.where(budget_code_id: coverage.budget_code_id, travel_id: travel.id)
      @approvements.each do |approvement|
        if approvement.approved_er == false || approvement.approved_er == nil
          flag = false
        end
      end
    end
   end

   if flag == true
    @approvements = Approvement.where(travel_id: travel.id)
    @approvements.each do |approvement|
      if approvement.approved_er == false || approvement.approved_er == nil
        approvement.update_attributes(:approved_er => true)
      end
    end
    self.update_status
   end

  end


end
