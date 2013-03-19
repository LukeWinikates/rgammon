class Move
  attr_accessor :start_point, :end_point

  def initialize(start_point, end_point)
    self.start_point = start_point
    self.end_point = end_point
  end
end
