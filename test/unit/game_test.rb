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

  test "taking a checker" do
    game = Game.create_default
    game.dice = Dice.new([1, 4])
    game.current_player = :black
    game.points.find_by_num(4).add_checker(:black)
    game.points.find_by_num(5).add_checker(:red)
    game.move(:black, 4, 5)
    assert game.points.find_by_num(5).belongs_to?(:black)
    assert game.points.find_by_num(5).checker_count == 1
    assert game.red_bar.checker_count == 1
  end

  test "limiting legal moves based on dice" do
    game = Game.create_default
    game.dice = Dice.new [4, 5]
    game.points.find_by_num(1).add_checker(:black)
    game.points.find_by_num(1).add_checker(:black)
    game.current_player = :black
    assert game.can_move?(:black, 1, 7) == false
    assert game.can_move?(:black, 1, 5)
    assert game.can_move?(:black, 1, 6)
    assert game.legal_turn?(:black, [Move.new(1, 5), Move.new(1, 6)])
  end

  test "limiting moves based on current player" do
    game = Game.create_default
    game.points.find_by_num(1).add_checker(:black)
    game.points.reload.find_by_num(1).add_checker(:black)
    game.points.find_by_num(24).add_checker(:red)
    game.points.reload.find_by_num(24).add_checker(:red)
    game.dice = Dice.new [3 ,2]
    game.current_player = :black
    assert game.legal_turn?(:black, [Move.new(1, 4), Move.new(1, 3)]) 
    assert !game.legal_turn?(:red, [Move.new(24, 21), Move.new(24, 22)])
    game.current_player = :red
    assert game.legal_turn?(:red, [Move.new(24, 21), Move.new(24, 22)])
  end

  test "saving dice value" do
    game = Game.create_default
    game.dice = Dice.new [4, 1]
    game.save!

    game2 = Game.find(game.id)
    assert game2.dice == game.dice
  end
end
