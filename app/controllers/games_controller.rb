class GamesController < ApplicationController
  def new
    @game = Game.new
    redirect_to @game
  end
  
  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game
    else
      redirect_to :back, notice: "Error creating a new game"
    end
  end
  
  def show
    @game = Game.find(params[:id])
    redirect_to @game
  end
end