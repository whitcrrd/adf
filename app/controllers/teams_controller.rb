class TeamsController < ApplicationController

  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
    @athletes = Athlete.all
  end

  def create
    @team = current_user.teams.create
    @team.date = Date.current
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
    if @team.save
      redirect_to edit_user_team_path(current_user, @team)
    else
      render :back
    end
  end

  def edit
    @team = Team.find(params[:id])
    @athletes = Athlete.all
    # @my_team = @team.athletes
  end

  def update
    @team = current_user.teams.find(params[:id])
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
    if @team.save
      redirect_to edit_user_team_path(current_user, @team)
    else
      render :back
    end
  end

  def destroy

  end

end
