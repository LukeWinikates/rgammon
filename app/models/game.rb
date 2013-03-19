class Game < ActiveRecord::Base
  attr_accessible :current_player, :dice
  has_many :points, :inverse_of => :game

  class << self
    def create_default
      game = new
      24.times { |i| game.points.build(:num => i+1) }
      game.save!
      game
    end
  end

  def roll_to_start
    self.current_player = [:black, :red][rand 2]
    self.dice = (rand 6) * 2
  end

  def move(player, start_point, end_point)
    if can_move_from(player, start_point) && can_move_to(player, end_point)
      points.find_by_num(start_point).remove_checker
      points.find_by_num(end_point).add_checker(player)
    end 
  end

  def can_move_from(player, start_point)
    point = points.find_by_num(start_point)
    point.belongs_to? player
  end

  def can_move_to(player, end_point)
    point = points.find_by_num(end_point)
    point.empty? || point.belongs_to?(player)
  end
end
