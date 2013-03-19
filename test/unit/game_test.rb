require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "create_defaut" do
    game = Game.create_default
    assert game.points.map(&:num) == (1..24).to_a
  end

  test "rolling for advantage" do
    game = Game.create_default
    assert !game.current_player
    game.roll_to_start
    assert !!game.current_player
    assert !!game.dice
  end

  test "moving a checker" do
    game = Game.create_default
    game.points.find_by_num(1).add_checker :black
    game.current_player = :black
    game.dice = Dice.new [1]
    game.move(:black, 1, 2)
    assert game.points.find_by_num(2).checker_count == 1
  end

  test "can move from" do
    game = Game.create_default
    game.points.find_by_num(1).add_checker :black
    game.save!
    assert game.can_move_from(:black, 1)
  end
end
