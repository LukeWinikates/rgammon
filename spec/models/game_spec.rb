require 'spec_helper'

describe Game do
  describe "persistence" do
    it "saves the dice value" do
      game = Game.create_default
      game.dice = Dice.new [4, 1]
      game.save!

      game.reload.dice.should == Dice.new([4,1])
    end 
  end

  describe "rolling to start" do
    let(:game) { Game.create_default }
    subject { game.reload }

    before { game.roll_to_start }
    its(:current_player) { should_not be_nil }
    its(:dice) { should_not be_nil }
  end

  describe "creating a traditional game" do
    let(:game) { Game.create_with_traditional_layout }

    it "has 24 points" do
      game.points.map(&:num).should == (1..24).to_a
    end

    it "has the traditional checker layout" do
      expect(game.point(1)).to have_checkers(:red, 2)
      expect(game.point(6)).to have_checkers(:black, 5)
      expect(game.point(8)).to have_checkers(:black, 3)
      expect(game.point(12)).to have_checkers(:red, 5)
      
      expect(game.point(13)).to have_checkers(:black, 5)
      expect(game.point(17)).to have_checkers(:red, 3)
      expect(game.point(19)).to have_checkers(:red, 5)
      expect(game.point(24)).to have_checkers(:black, 2)

      (%w(2, 3, 4, 5, 7, 9, 10, 11) +
       %w(14, 15, 16, 18, 20, 21, 22, 23)).each do |num|
        game.point(num).should have_no_checkers 
      end
    end
  end

  describe "moving checkers" do
    let(:game) { Game.create_default }
    let(:dice) { Dice.new [1, 6] }

    before do
      game.current_player = :black
      game.point(1).add_checker :black
      game.dice = dice
      game.move(:black, 1, 2)
    end

    it "allows moving from a space if the player has a checker there" do
      game.can_move_from(:black, 2).should be_true
    end

    it "reduces the number of checkers at the start point" do
      game.point(1).reload.checker_count.should == 0
    end

    it "increments the number of checkers at the end point" do
      game.point(2).checker_count.should == 1
    end

    it "updates the dice" do
      game.dice.should == Dice.new([6])
    end

    context "when the last move of the turn is complete" do
      let(:dice) { Dice.new [1] }

      it "re-rolls the dice" do
        game.reload.dice.should_not be_empty
      end
      
      it "changes the current player" do
        game.current_player.should == :red 
      end
    end

    context "when a player other than the current player tries to move" do
      it "rejects the move" do
        game.can_move?(:red, 2, 1).should be(false)
        game.move(:red, 2, 1)
        game.point(1).should_not have_checkers(:red, 1)
      end
    end

    context "when the player tries to move the wrong number of spaces" do
      it "rejects the move" do
        game.can_move?(:black, 2, 6).should be(false)
        game.move(:black, 2, 6)
        game.point(6).should have_checkers(nil, 0)
      end
    end

    context "when taking a checker" do
      let(:layout) do
        { 1 => { :checker_count => 2, :color => :black },
          2 => { :checker_count => 2, :color => :black },
          4 => { :checker_count => 1, :color => :red } }
      end
      let(:game) do
        game = Game.from_layout(layout, 4)
        game.update_attributes!(:dice => Dice.new([2, 5]), :current_player => :black) 

        game.move(:black, 2, 4)
        game
      end

      it "moves the taken checker to the bar" do
        game.red_bar.checker_count.should == 1
      end

      it "changes the color of the point" do
        game.point(4).should have_checkers(:black, 1)
      end
    end
  end
end
