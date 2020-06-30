class AddAmountToApprovements < ActiveRecord::Migration[5.2]
  def change
    add_column :approvements, :amount, :decimal
  end
end
