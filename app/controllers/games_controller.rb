class GamesController < ApplicationController
  before_filter :authorize, :only => [:edit, :update]
  def index
    @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    @teams = @game.teams
  end

  def edit
    @game = Game.find params[:id]
    @athletes = []
    @ath_by_pos = [] 
    @athletes = Athlete.top_by_position
    @ath_by_pos = Athlete.top_tens_by_position
    if @game.full?
      render :notice => "game is full"
    else
      @new_team = @game.teams.build
    end
  end

  def update
    @game = Game.find params[:id]
    if @game.update_attributes params[:game]
      @team = @game.teams.last ########## there will always be a last team
      if @team
        @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
      end
      redirect_to @game
    else
      render :edit
    end
  end
end