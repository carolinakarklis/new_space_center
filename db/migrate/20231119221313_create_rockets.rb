class CreateRockets < ActiveRecord::Migration[6.0]
  def change
    create_table :rockets do |t|
      t.references :load_type, null: false, foreign_key: true
      t.integer :fuel_days

      t.timestamps
    end
  end
end
