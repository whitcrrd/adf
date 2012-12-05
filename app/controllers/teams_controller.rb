class TeamsController < ApplicationController

  before_filter :authorize, :only => [:show, :edit]
  respond_to :json, :html
  def index
    @teams = Team.all_user_teams(current_user)
  end

  def new
    @team = Team.new
    @team.name = "#{current_user.name}'s Team"
    # @athletes = Athlete.top_by_position
    @athletes = Athlete.all
    @ath_by_pos = Athlete.all

    # @ath_by_pos = Athlete.top_tens_by_position
    # REVIEW: add explanation
    # RETURNS [ [1, <athl obj>], 2, ]

  end

  def create
    @team = current_user.teams.build params[:team]
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
    @athletes = Athlete.all
    @ath_by_pos = Athlete.top_tens_by_position
    # REVIEW: move to before filter for #edit, #new
  end

  def update
    @team = Team.find(params[:id])
    athlete = Athlete.find params[:athlete_id]
    if @team.athletes << athlete
      render :json => {:success => true, :player_card => render_to_string(:partial => 'athletes/athlete_pic', :locals => {:athlete => athlete})}
    else
      render :json => {:success => false}
    end

  end
end
