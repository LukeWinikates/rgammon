class Dice
  attr_accessor :values
  def initialize(values)
    @values = values
  end

  def contains?(value)
    @values.include? value
  end
end
