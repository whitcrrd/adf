class UsersController < ApplicationController
  def index
    @users = User.joins(:teams => :user).order("teams.points DESC")
  end

  def show
    @user = User.find(current_user.id)
  end

end

