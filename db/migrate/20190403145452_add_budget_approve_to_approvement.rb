class AddBudgetApproveToApprovement < ActiveRecord::Migration[5.2]
  def change
    add_reference :approvements, :budget_approver
  end
end
