require 'spec_helper'

describe Point do
  describe "blots" do
    context "when a point has one checker" do
      let(:point) { Point.new :checker_count => 1 }
      it "is a blot" do
        point.should be_blot
      end
    end
    
    context "when a point has two checkers" do
      let(:point) { Point.new :checker_count => 2 }
      it "is not a blot" do
        point.should_not be_blot
      end
    end
    
    context "when a point has no checkers" do
      let(:point) { Point.new :checker_count => 0 }
      it "is not a blot" do
        point.should_not be_blot
      end
    end
  end
end
