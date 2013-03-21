class Dice
  attr_accessor :values
  def initialize(values)
    @values = values.sort
  end

  def contains?(value)
    @values.include? value
  end

  def to_s
    values.join ","
  end

  def ==(other_dice)
    values == other_dice.values
  end

  def <=>(other_dice)
    values <=> other_dice.values
  end
end
