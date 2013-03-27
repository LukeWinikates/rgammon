class Game < ActiveRecord::Base
  attr_accessible :current_player, :dice
  has_many :points, :inverse_of => :game
  composed_of :dice, :class_name => "Dice", :mapping => %w(dice to_s), :constructor => Proc.new { |value_string| Dice.new(value_string.split(",").map(&:to_i)) }

  def red_bar
    @red_bar ||= Bar.new 
  end

  def black_bar
    @black_bar ||= Bar.new
  end

  def point(num)
    points.find_by_num num
  end

  class << self
    def create_default
      game = new
      24.times { |i| game.points.build(:num => i+1) }
      game.save!
      game
    end

    def create_with_traditional_layout 
      game = create_default
      defaults = [
        {:num => 1, :color => :red, :checker_count => 2 },
        {:num => 6, :color => :black, :checker_count => 5},
        {:num => 8, :color => :black, :checker_count => 3},
        {:num => 12, :color => :red, :checker_count => 5},
        {:num => 13, :color => :black, :checker_count => 5},
        {:num => 17, :color => :red, :checker_count => 3},
        {:num => 19, :color => :red, :checker_count => 5},
        {:num => 24, :color => :black, :checker_count => 2}
      ]
      defaults.each do |d|
        game.points.find_by_num(d[:num]).update_attributes(d)
      end

      game
    end
  end

  def legal_turn?(player, moves)
    moves.all? do |m|
      can_move?(player,  m.start_point, m.end_point)
    end
  end

  def can_move?(player, start_point, end_point)
    current_player.try(:to_sym) == player && dice_allows?(start_point, end_point) && can_move_from(player, start_point) && can_move_to(player, end_point)
  end

  def dice_allows?(start_point, end_point)
    dice.contains?((end_point-start_point).abs)
  end

  def roll_to_start
    self.current_player = [:black, :red][rand 2]
    self.dice = (rand 6) * 2
  end

  def move(player, start_point, end_point)
    if can_move?(player, start_point, end_point)
      points.find_by_num(start_point).remove_checker
      dest = points.find_by_num(end_point) 
      take_point(dest)
      dest.add_checker(player)
    end 
  end

  def take_point(point)
    if point.checker_count > 0
      bar = point.color.to_sym == :black ? black_bar : red_bar
      bar.checker_count = point.checker_count
    end
  end

  def can_move_from(player, start_point)
    point = points.find_by_num(start_point)
    point.belongs_to? player
  end

  def can_move_to(player, end_point)
    point = points.find_by_num(end_point)
    point.empty? || point.blot? || point.belongs_to?(player)
  end
end
