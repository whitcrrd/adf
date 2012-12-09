class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    user.add_friends
    session[:user_id] = user.id
    redirect_back_or root_path
    # redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have successfully logged out"
  end
end