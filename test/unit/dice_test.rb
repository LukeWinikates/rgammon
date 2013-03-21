require 'test_helper'

class DiceTest < ActiveSupport::TestCase
  test "equality" do
    assert Dice.new([1, 1]) == Dice.new([1, 1])
    assert Dice.new([1, 2]) == Dice.new([2, 1])
    assert Dice.new([4, 5]) != Dice.new([2, 4])
  end
end
