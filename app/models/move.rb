class Move
  attr_accessor :start_point, :end_point

  def initialize(start_point, end_point)
    self.start_point = start_point
    self.end_point = end_point
  end

  def to_params
    "?start_point=#{start_point}&end_point=#{end_point}"
  end

  def read_attribute_for_serialization(attr)
    send(attr.to_sym)
  end
end
