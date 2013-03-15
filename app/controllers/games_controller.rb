class GamesController < ApplicationController
  def show
    @model = Game.find [params[:id]]
    render :json => @model 
  end

  def create
    @model = Game.create_default
    render :json => @model
  end
end
