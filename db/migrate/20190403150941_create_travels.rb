class CreateTravels < ActiveRecord::Migration[5.2]
  def change
    create_table :travels do |t|
      t.string :destination
      t.string :purpose
      t.date :date_of_departure
      t.date :date_of_return

      t.timestamps
    end
  end
end
