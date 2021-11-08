class CreatePlaygrounds < ActiveRecord::Migration[6.1]
  def change
    create_table :playgrounds do |t|
      t.string :username
      t.string :roomName
      t.string :password
      t.string :scores # array of the 2 players scores
      t.string :status #array of status for the last game
      t.text :moves
      t.string :people # array of the 2 players name
      t.string :next # who is playing next
      t.string :wonby # symbol that won

      t.timestamps
    end
  end
end
