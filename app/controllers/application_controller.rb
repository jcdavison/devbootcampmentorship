class ApplicationController < ActionController::Base

  protect_from_forgery

  protected

  def logged_in?
    session[:current_user_id] != nil ? true : false  
  end

  def current_user
    @user = User.find_by_id(session[:current_user_id])
  end

  def user_access?
    if logged_in? != true
      redirect_to sign_in_path
    end
  end

  def is_admin?
    if current_user.admin
      return true
    elsif current_user
      redirect_to thank_you_path(id: current_user.id)
    else
      redirect_to sign_up_path
    end
  end

  def route_user(user)
    redirect_to '/thank_you'
  end

  helper_method :logged_in?, :current_user, :user_access?, :admin?

end
