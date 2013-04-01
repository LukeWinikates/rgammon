require 'spec_helper'

describe Move do
  describe "initialization" do
    subject(:move) { Move.new(1, 2) }
    
    its(:start_point) { should == 1 }
    its(:end_point) { should == 2 }
  end
end
