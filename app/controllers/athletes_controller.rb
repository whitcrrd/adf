class AthletesController < ApplicationController
  before_filter :authorize
  
  def destroy
    @team = current_user.teams.find(params[:team_id])
    @team.athletes.destroy(params[:id])
    redirect_to :back
  end

end