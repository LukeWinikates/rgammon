require 'test_helper'

class GameTest < ActiveSupport::TestCase
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
