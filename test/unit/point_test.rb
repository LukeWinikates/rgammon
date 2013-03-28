require 'test_helper'

class PointTest < ActiveSupport::TestCase
  test "removing checkers" do
    p = Point.new :color => :red, :checker_count => 1, :game => Game.create!, :num => 1
    assert p.remove_checker
  end
end
