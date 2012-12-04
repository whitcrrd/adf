class TeamsController < ApplicationController

  before_filter :authorize, :only => [:show]
  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
    @team.name = "#{current_user.name}'s Team"
    @athletes = Athlete.top_by_position
    @ath_by_pos = Athlete.top_tens_by_position
  end

  def create
    @team = current_user.teams.create
    # @team.date = (Time.now.utc + Time.zone_offset('EST')).to_date
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
    @team.name = params[:team][:name].blank? ? "Team_#{@team.date}" : params[:team][:name]
    if @team.save
      redirect_to edit_team_path(@team)
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
    @athletes = Athlete.top_by_position
    @ath_by_pos = Athlete.top_tens_by_position
  end

  def update
    @team = current_user.teams.find(params[:id])
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
    @team.name = params[:team][:name].blank? ? "Team_#{@team.date}" : params[:team][:name]
    if @team.save
      redirect_to edit_team_path(@team)
    else
      redirect_to :back
    end
  end
end
