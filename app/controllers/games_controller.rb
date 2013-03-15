class GamesController < ApplicationController
  def show
    @model = Game.includes([:points]).find params[:id]
    render :json => @model, :serializer => GameSerializer 
  end

  def create
    @model = Game.create_default
    render :json => @model
  end
end
