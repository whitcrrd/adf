class TeamsController < ApplicationController

  before_filter :authorize, :only => [:show]
  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
    @athletes = Athlete.all
  end

  def create
    # @game = Game.find(params[:game_id])
    # if @game == nil
    #   @game = Game.new
    #   @game.save
    # end
    @team = current_user.teams.create
    @team.date = (Time.now.utc + Time.zone_offset('EST')).to_date
    # @team.date = Date.today
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
    @team.name = params[:team][:name]
    # @team.game_id = @game.id
    if @team.save
      redirect_to edit_team_path(@team)
      # redirect_to game_team_path(@game.id, @team.id)
    else
      render :back
    end
  end

  def show
    @team = Team.find(params[:id])
    @game = @team.game
  end


  def edit
    @team = Team.find(params[:id])
    @athletes = Athlete.all
    # @my_team = @team.athletes
  end

  def update
    @team = current_user.teams.find(params[:id])
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
    @team.name = params[:team][:name]
    if @team.save
      redirect_to edit_team_path(@team)
    else
      redirect_to :back
    end
  end

  def destroy

  end

end
