require 'spec_helper'

describe "games" do
  describe "#show" do
    it "returns a success status" do
      game = Game.create_default
      move = Move.new(1, 2)
      get "games/#{game.id}/moves/try#{move.to_params}"
      expect(response).to be_success
    end
  end
end
