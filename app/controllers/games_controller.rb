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
    # @game.teams[1].name = "#{current_user.name}'s Team"
    @athletes = []
    @ath_by_pos = [] ########## for individual menus
    ['PG','SG','SF','PF','C'].each { |pos| @athletes += Athlete.top_pos(pos) }
    ['PG','SG','SF','PF','C'].each_with_index { |pos, index| @ath_by_pos[index] = Athlete.top_pos(pos) } ########### for individual menus
    if @game.full?
      render :notice => "game is full"
    else
      @new_team = @game.teams.build
    end
  end

  def update
    @game = Game.find params[:id]
    if @game.update_attributes params[:game]
      @team = @game.teams.last
      if @team
        @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
      end
      redirect_to @game
    else
      render :edit
    end
  end
end