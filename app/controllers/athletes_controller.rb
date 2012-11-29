class AthletesController < ApplicationController
  def destroy
    @team = Team.find(params[:team_id])
    @team.athletes.destroy(params[:id])
    redirect_to :back
  end

end