class Point < ActiveRecord::Base
  attr_accessible :checker_count, :color, :num, :game
  belongs_to :game, :inverse_of => :points
  
  def blot?
    checker_count == 1
  end

  def empty?
    checker_count == 0
  end

  def add_checker(color)
    self.checker_count ||= 0
    if blot? && !belongs_to?(color)
      self.color = color
      self.checker_count = 0
    end

    if empty?
      self.color = color
    end

    if self.color.try(:to_sym) == color.to_sym 
      self.checker_count += 1
    end

    save!
  end

  def belongs_to?(player)
    self.color.try(:to_sym) == player && self.checker_count > 0
  end

  def remove_checker
    if checker_count > 0
      self.checker_count -= 1
    end
    self.color = nil if self.checker_count == 0 

    self.save!
  end
end
