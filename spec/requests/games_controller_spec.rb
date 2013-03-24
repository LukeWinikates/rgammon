require 'spec_helper'

describe "games" do
  describe "#show" do
    it "returns a success status" do
      game = Game.create_default
      get "games/#{game.id}"
      expect(response).to be_success
      expect(response.body).to eq(GameSerializer.new(game).to_json)
    end
  end
end
