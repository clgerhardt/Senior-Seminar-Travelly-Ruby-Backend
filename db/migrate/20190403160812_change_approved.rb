class ChangeApproved < ActiveRecord::Migration[5.2]
  def change
    rename_column :approvements, :approved, :approved_tf
  end
end
