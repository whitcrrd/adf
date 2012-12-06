class GamesController < ApplicationController
  before_filter :authorize, :only => [:edit, :update]
  def index
    @games = Game.all_user_games(current_user)
  end

  def show
    # REVIEW: Move to before filter
    @game = Game.find_by_slug(params[:id])
    @teams = @game.teams
  end

  def edit
    @game = Game.find_by_slug(params[:id])
    @athletes = []
    @ath_by_pos = []
    @athletes = Athlete.top_by_position
    @ath_by_pos = Athlete.top_tens_by_position
    if @game.teams.count == 1 && (@game.teams.first.user_id != current_user.id) && (current_user.id != nil)
      @new_team = @game.teams.create(:user_id => current_user.id, :name => current_user.name)
      redirect_to edit_team_path(@new_team)
    else
      redirect_to root_url, :notice => "The game you tried to join is full. Please make a new game."
    end
  end

  def update
    @game = Game.find_by_slug(params[:id])
    if @game.update_attributes params[:game]
      # REVIEW: add a method to grab the specific team you want
      # e.g. @game.rival_team
      if @team = @game.teams.last
        @team.athlete_ids = params[:athlete_ids].keys if params[:athlete_ids]
        # @team.save DO YOU NEED THIS?
      end
      redirect_to @game
    else
      render :edit
    end
  end
end