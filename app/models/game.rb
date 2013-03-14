class Game < ActiveRecord::Base
  attr_accessible :current_player
  has_many :points, :as => :game
end
