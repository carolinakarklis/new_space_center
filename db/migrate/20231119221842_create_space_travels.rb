class CreateSpaceTravels < ActiveRecord::Migration[6.0]
  def change
    create_table :space_travels do |t|
      t.datetime, :start_at
      t.integer, :duration_in_days
      t.references, :planet
      t.references, :space_vehicle
      t.text, :mission_description
      t.integer :status

      t.timestamps
    end
  end
end
