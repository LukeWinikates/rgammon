require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "create_defaut" do
    game = Game.create_default
    assert game.points.map(&:num) == (1..24).to_a
  end
end
