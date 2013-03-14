class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :game_id, :null => false
      t.string :color
      t.integer :checker_count
      t.integer :num

      t.timestamps
    end
  end
end
