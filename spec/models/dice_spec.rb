require 'spec_helper'

describe Dice do
  it "should check equality in terms of the face values of the dice" do
    Dice.new([1, 1]).should == Dice.new([1, 1])
    Dice.new([1, 2]).should == Dice.new([2, 1])
    Dice.new([4, 5]).should_not == Dice.new([2, 4])
  end

  it "should be considered empty if it contains no values" do
    Dice.new([]).empty?.should be_true
  end

  describe "rolling the dice" do
    subject { Dice.roll }

    it { should be_a(Dice) }

    it "assigns random values between 1 and 6 for each die" do
      10.times do
        Dice.roll.values.each { |v| v.should > 0; v.should < 7 }
      end
    end
  end

  describe "removing a die" do
    let(:dice) { Dice.new([4, 5]) }
    before do
      dice.remove 4
    end

    it "contains only the other die" do
      dice.should == Dice.new([5])
    end
  end
end
