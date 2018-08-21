class CreateRolls < ActiveRecord::Migration[5.1]
  def change
    create_table :rolls do |t|
      t.string :player
      t.integer :knocked_pins
      t.references :game_id
      t.timestamps
    end
  end
end
