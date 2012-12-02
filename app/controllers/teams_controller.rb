class TeamsController < ApplicationController

  before_filter :authorize, :only => [:show]
  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
    @athletes = Athlete.joins(:professional_team, :season_average).where("professional_teams.game_time is not null and (season_averages.points > 12 or season_averages.rebounds > 7 || season_averages.assists > 5)").includes(:professional_team)
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
    @team.name = params[:team][:name] == "" ? params[:team][:name] : "something"
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
    @athletes = Athlete.joins(:professional_team, :season_average).where("professional_teams.game_time is not null and (season_averages.points > 12 or season_averages.rebounds > 7 || season_averages.assists > 5)")
    # @athletes = Athlete.joins(:professional_team).where("professional_teams.game_time is not null")
    # @athletes = Athlete.all
  end

  def update
    @team = current_user.teams.find(params[:id])
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
    @team.name = params[:team][:name] == "" ? params[:team][:name] : "something"
    if @team.save
      redirect_to edit_team_path(@team)
    else
      redirect_to :back
    end
  end

  def destroy

  end

end
