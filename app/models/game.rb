class Game < ActiveRecord::Base
  attr_accessible :current_player
  has_many :points, :inverse_of => :game

  class << self
    def create_default
      game = new
      24.times { |i| game.points.build(:num => i+1) }
      game.save!
      game
    end
  end
end
