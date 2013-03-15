class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :game_id, :null => false
      t.string :color
      t.integer :checker_count, :null => false, :default => 0
      t.integer :num, :null => false

      t.timestamps
    end
  end
end
