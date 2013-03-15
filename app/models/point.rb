class Point < ActiveRecord::Base
  attr_accessible :checker_count, :color, :num
  belongs_to :game, :inverse_of => :points
end
