class CreateSpaceVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :space_vehicles do |t|
      t.string :name
      t.integer :km_per_hour
      t.references :agency, null: false, foreign_key: true
      t.references :vehicleable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
