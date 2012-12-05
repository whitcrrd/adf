class AthletesController < ApplicationController
  before_filter :authorize

  def destroy
    @team = Team.find(params[:team_id])
    @team.athletes.destroy(params[:id])
    # REVIEW: maybe replace with a descriptive method like remove_athlete

    render :json => {:success => true }
  end

end