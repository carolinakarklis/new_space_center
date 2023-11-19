class CreateSpaceBuses < ActiveRecord::Migration[6.0]
  def change
    create_table :space_buses do |t|
      t.integer :max_crew
      t.integer :fuel_days

      t.timestamps
    end
  end
end
