require 'test_helper'

class MoveTest < ActiveSupport::TestCase
  test "initialization" do
    m = Move.new(1, 2)
    assert m.start_point == 1
    assert m.end_point ==2
  end
end
