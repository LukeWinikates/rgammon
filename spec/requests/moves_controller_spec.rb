require 'spec_helper'
require 'json'

describe "moves" do
  describe "checking a move" do
    it "returns a success status" do
      game = Game.create_default
      move = Move.new(1, 2)
      get "games/#{game.id}/moves/try#{move.to_params}"
      expect(response).to be_success
    end
  end

  describe "submitting a move" do
    let(:game) { Game.from_layout(Layouts.traditional, 24) }
    let(:move) { Move.new(24, 23) }
    let(:json) { { :format => :json, :move => MoveSerializer.new(move).as_json(:root => false) }}
    let(:parsed_game) do
      game_hash = JSON.parse(response.body)["game"]
      points = game_hash.delete("points")
      points = Hash[points.map {|p| [p["num"], p]}]
      game_hash[:dice] = Dice.from_string game_hash.delete("dice")
      parsed_game = Game.from_layout(points, points.length)    
      parsed_game.update_attributes(game_hash)
      parsed_game
    end
    
    before do
      game.update_attributes({dice: Dice.new([1, 3]), current_player: :black})
      post "games/#{game.id}/moves", json
    end

    it "returns a success status" do
      response.should be_success
    end

    it "adds the move to the game" do
      pending
    end

    it "moves the checker" do
      parsed_game.point(23).should have_checkers(:black, 1)
    end

    it "removes the corresponding dice" do
      parsed_game.dice.should == Dice.new([3])
    end
  end
end
