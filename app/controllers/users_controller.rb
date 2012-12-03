class UsersController < ApplicationController
  def index
    # @users = User.joins(:teams => :user).order("teams.points DESC")
    @users = User.todays_top_points(Date.today) #SCOTT TEST THIS PLEASE!
    @teams = Team.order('points DESC').where("date = ?", Date.today)
  end

  def show
    @user = current_user
  end

end

