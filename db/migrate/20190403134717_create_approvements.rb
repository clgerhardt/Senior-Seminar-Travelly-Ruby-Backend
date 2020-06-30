class CreateApprovements < ActiveRecord::Migration[5.2]
  def change
    create_table :approvements do |t|
      t.boolean :approved
      t.datetime :date_budget_app
      t.datetime :date_payment_mgr

      t.timestamps
    end
  end
end
