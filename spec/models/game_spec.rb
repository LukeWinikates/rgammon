require 'spec_helper'

describe Game do
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
end
