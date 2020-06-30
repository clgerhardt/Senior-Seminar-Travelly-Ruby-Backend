class AddTravelToApprovement < ActiveRecord::Migration[5.2]
  def change
    add_reference :approvements, :travel, foreign_key: true
  end
end
