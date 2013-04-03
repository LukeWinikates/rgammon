class MovesController < ApplicationController
  def try
  end

  def create
    game = Game.find(params[:game_id])
    move = Move.new(params[:move][:start_point].to_i, params[:move][:end_point].to_i)
    game.move(game.current_player.to_sym, move.start_point, move.end_point)
    game.save!
    render :json => game
  end
end
