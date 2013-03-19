class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :current_player
      t.string :dice
      t.timestamps
    end
  end
end
