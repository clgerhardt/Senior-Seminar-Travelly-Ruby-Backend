class AddEmailAndPasswordToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :email, :string
    add_index :employees, :email, unique: true
    add_column :employees, :password_digest, :string
  end
end
