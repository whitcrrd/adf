class UsersController < ApplicationController
  def index
    # @users = User.joins(:teams => :user).order("teams.points DESC")
    @users = User.todays_top_points(Date.today) #SCOTT TEST THIS PLEASE!
  end

  def show
    @user = User.find(current_user.id)
  end

end

