require 'spec_helper'

describe "games" do
  describe "#show" do
    it "returns a success status" do
      game = Game.create_default
      get "games/#{game.id}"
      expect(response).to be_success
    end
  end
end
