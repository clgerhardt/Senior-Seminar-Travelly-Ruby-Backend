class AddBooleanToApprovement < ActiveRecord::Migration[5.2]
  def change
    add_column :approvements, :approved_er, :boolean
  end
end
