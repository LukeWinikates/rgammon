class DiceRollsController < ApplicationController
  def create
    game = Game.find params[:game_id]
    game.roll_to_start if game.unstarted?
    render :json => game
  end
end
