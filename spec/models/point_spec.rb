require 'spec_helper'

describe Point do
  describe "blots & empties" do
    context "when a point has one checker" do
      let(:point) { Point.new :checker_count => 1 }
      it "is a blot" do
        point.should be_blot
        point.should_not be_empty
      end
    end
    
    context "when a point has two checkers" do
      let(:point) { Point.new :checker_count => 2 }
      it "is not a blot" do
        point.should_not be_blot
        point.should_not be_empty
      end
    end
    
    context "when a point has no checkers" do
      let(:point) { Point.new :checker_count => 0 }
      it "is not a blot" do
        point.should_not be_blot
        point.should be_empty
      end
    end
  end

  describe "adding checkers" do
    let(:game) { Game.create! }
    let(:attributes) { {:num => num, :color => start_color, :checker_count => checker_count, :game => game } }
    let(:num) { 1 }
    let(:start_color) { nil }
    let(:checker_count) { 0 }
    let(:point) { Point.create! attributes }

    before do
      point.add_checker color
    end

    describe "on an empty point" do
      let(:color) { :black }

      specify { point.should have_checkers(:black, 1) }
    end

    describe "on a blot" do
      let(:checker_count) { 1 }
      let(:start_color) { :black }
      let(:color) { :red }
      
      specify { point.should have_checkers(color, 1) }
    end

    describe "on a space controlled by the same color" do
      let(:checker_count) { 1 }
      let(:start_color) { :black }
      let(:color) { :black }
      
      specify { point.should have_checkers(color, 2) }
    end

    describe "on a blocked point" do
      let(:checker_count) { 2 }
      let(:start_color) { :black }
      let(:color) { :red }
      
      specify { point.should have_checkers(start_color, 2) }
    end
  end
end
