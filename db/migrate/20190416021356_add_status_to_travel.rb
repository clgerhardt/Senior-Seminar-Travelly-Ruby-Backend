class AddStatusToTravel < ActiveRecord::Migration[5.2]
  def change
    add_column :travels, :status, :integer
  end
end
