class Game < ActiveRecord::Base
  attr_accessible :current_player, :dice
  has_many :points, :inverse_of => :game
  composed_of :dice, :class_name => "Dice", :mapping => %w(dice to_s), :constructor => Proc.new { |value_string| Dice.from_string value_string }

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

    def from_layout(layout, num_points)
      game = new
      num_points.times do |i| 
        layout_entry = { :num => i + 1 }.merge(layout[i+1] || {} )
        game.points.build(layout_entry) 
      end

      game.save!
      game
    end

    def create_with_traditional_layout 
      from_layout(Layouts.traditional, 24)
    end
  end

  def can_move?(player, start_point, end_point)
    current_player.try(:to_sym) == player && dice_allows?(start_point, end_point) && can_move_from(player, start_point) && can_move_to(player, end_point)
  end

  def dice_allows?(start_point, end_point)
    dice.contains?((end_point-start_point).abs)
  end

  def unstarted?
    self.current_player.nil?
  end

  def random_player 
    [:black, :red][rand 2]
  end

  def roll_to_start
    update_attributes(:current_player => random_player, :dice => Dice.roll)
  end

  def move(player, start_point, end_point)
    if can_move?(player, start_point, end_point)
      points.find_by_num(start_point).remove_checker
      dest = points.find_by_num(end_point) 
      take_point(dest)
      dest.add_checker(player)
      dice.remove((start_point-end_point).abs)
      next_turn
    end 
  end

  def next_turn
    if dice.empty?
      update_attributes(:current_player => other_player, :dice => Dice.roll)
    end
  end

  def other_player
    self.current_player.try(:to_sym) == :black ? :red : :black 
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
