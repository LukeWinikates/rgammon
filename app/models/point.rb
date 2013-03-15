class Point < ActiveRecord::Base
  attr_accessible :checker_count, :color, :num
  belongs_to :game, :inverse_of => :points
  
  def blot?
    checker_count == 1
  end

  def empty?
    checker_count == 0
  end

  def add_checker(color)
    if blot? && self.color != color
      self.color = color
      self.checker_count = 0
    end

    if empty?
      self.color = color
    end

    if self.color == color
      self.checker_count += 1
    end
  end

  def remove_checker
    if checker_count > 0
      self.checker_count -= 1
    end
  end
end
