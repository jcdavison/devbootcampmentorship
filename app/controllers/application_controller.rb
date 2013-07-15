class ApplicationController < ActionController::Base

  protect_from_forgery

  protected

  def logged_in?
    session[:current_user_id] != nil ? true : false  
  end

  def current_user
    User.find_by_id(session[:current_user_id])
  end

  def user_access?
    unless logged_in?
      redirect_to sign_in_path
    end
  end

  def is_admin?
    current_user && current_user.admin? ? true : false
  end

  def protect_admin
    unless is_admin?
      redirect_to root_path
    end
  end

  helper_method :logged_in?, :current_user, :admin?, :protect_admin

end
