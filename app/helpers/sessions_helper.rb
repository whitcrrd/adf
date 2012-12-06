module SessionsHelper

  def redirect_back_or(default)
    redirect_to(session[:return_to]) || default
    session.delete(:return_to)
  end

  def authorize
    unless current_user
      store_location
      flash[:error] = "You must be signed in to access this page."
      redirect_to root_path
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end