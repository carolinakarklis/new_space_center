class CreateLoadTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :load_types do |t|
      t.integer :name
      t.integer :weight
      t.text :description

      t.timestamps
    end
  end
end
