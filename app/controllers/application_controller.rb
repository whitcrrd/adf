class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    redirect_to root_path, :notice => "please login first" unless current_user
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
