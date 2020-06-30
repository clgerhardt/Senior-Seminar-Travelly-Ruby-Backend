class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :commented, polymorphic: true, index: true
      t.timestamps
    end
  end
end
