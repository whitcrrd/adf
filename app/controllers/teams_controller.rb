class TeamsController < ApplicationController

  def new
    @team = Team.new
    @athletes = Athlete.all
  end

  def create
    @team = current_user.teams.create
    @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
  end

end
