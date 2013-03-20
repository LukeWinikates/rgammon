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
    g = Game.create!
    p = Point.new :num => 1, :checker_count => 0, :game => g
    p.save!
    p.add_checker :black
    assert p.color == :black
    assert p.checker_count == 1

    p = Point.new :color => :red, :checker_count => 2, :num => 2, :game => g
    p.add_checker(:black)
    assert p.color == :red
    assert p.checker_count == 2

    p = Point.new(:game => g, :num => 3)
    p.add_checker :black
    p.add_checker :black
    assert p.belongs_to? :black
    assert p.checker_count == 2
  end

  test "removing checkers" do
    p = Point.new :color => :red, :checker_count => 1, :game => Game.create!, :num => 1
    assert p.remove_checker
  end
end
