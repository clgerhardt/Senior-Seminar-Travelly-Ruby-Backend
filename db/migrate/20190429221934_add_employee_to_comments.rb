class AddEmployeeToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :employee, foreign_key: true
  end
end
