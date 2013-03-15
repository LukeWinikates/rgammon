require 'test_helper'

class PointTest < ActiveSupport::TestCase
  test "blots" do
    p = Point.new :checker_count => 1
    assert p.blot?
  end

  test "empty?" do
    p = Point.new :checker_count => 0
    assert p.empty?
  end

  test "adding checkers" do
    p = Point.new
    assert p.add_checker "BLACK"
    assert p.color == "BLACK"
    assert p.checker_count == 1


    p = Point.new :color => "RED", :checker_count => 2
    assert !p.add_checker("BLACK")
    assert p.color == "RED"
    assert p.checker_count == 2
  end

  test "removing checkers" do
    p = Point.new :color => "RED", :checker_count => 1
    assert p.remove_checker
    assert !p.remove_checker
  end
end
