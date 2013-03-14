class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :current_player

      t.timestamps
    end
  end
end
