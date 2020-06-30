class AddEmployeeToTravel < ActiveRecord::Migration[5.2]
  def change
    add_reference :travels, :employee, foreign_key: true
  end
end
