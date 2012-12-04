class AthletesController < ApplicationController
  before_filter :authorize

  def destroy
    @team = current_user.teams.find(params[:team_id])
    @team.athletes.destroy(params[:id])
    render :json => {:success => true }
  end

end