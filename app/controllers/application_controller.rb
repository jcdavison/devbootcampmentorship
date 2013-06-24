class ApplicationController < ActionController::Base

  protect_from_forgery

  protected

  def logged_in?
    session[:current_user_id] != nil ? true : false  
  end

  def current_user
    @user = User.find(session[:current_user_id])
    @user
  end

  def user_access?
    if logged_in? != true
      redirect_to sign_in_path
    end
  end

  def admin?
    unless logged_in? && current_user.admin
      redirect_to root_path
    end
  end

  def route_user(user)
    redirect_to '/thank_you'
  end

  helper_method :logged_in?, :current_user, :user_access?, :admin?

end
