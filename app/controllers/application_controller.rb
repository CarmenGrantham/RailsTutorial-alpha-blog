class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  
  # This makes current_user and logged_in available to views
  helper_method :current_user, :logged_in?
  def current_user
    # Return user if there is one in the session, but ||= means only do check if value is nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # Remove the current_user from stored
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
