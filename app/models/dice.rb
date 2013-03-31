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
  
  class << self
    def random_value 
      (rand 6) + 1
    end

    def roll
      Dice.new([] << random_value << random_value)
    end
  end
end
