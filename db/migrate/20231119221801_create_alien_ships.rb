class CreateAlienShips < ActiveRecord::Migration[6.0]
  def change
    create_table :alien_ships do |t|
      t.integer, :max_crew
      t.integer :abductions_number

      t.timestamps
    end
  end
end
