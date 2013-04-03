module Layouts
  def self.traditional
    {
       1 => { :color => :red, :checker_count => 2 },
       6 => { :color => :black, :checker_count => 5},
       8 => { :color => :black, :checker_count => 3},
       12 => { :color => :red, :checker_count => 5},
       13 => { :color => :black, :checker_count => 5},
       17 => { :color => :red, :checker_count => 3},
       19 => { :color => :red, :checker_count => 5},
       24 => { :color => :black, :checker_count => 2}
    }
  end
end
