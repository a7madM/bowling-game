class CreateRolls < ActiveRecord::Migration[5.1]
  def change
    create_table :rolls do |t|
      t.string :player
      t.integer :knocked_pins
      t.references :game
      t.timestamps
    end
  end
end
