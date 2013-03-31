require 'spec_helper'

RSpec::Matchers.define :have_dice do
  match do |actual|
    !actual.dice.nil?
  end
end

describe "dicerolls" do
 describe "#create" do
  let(:game) { Game.create_default }
  
  subject { game.reload }

  before do
    post "games/#{game.id}/dice_rolls"
  end

  it { should have_dice }
  its(:current_player) { should_not be_nil }
 end
end


