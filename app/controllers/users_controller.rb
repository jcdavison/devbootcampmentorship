class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p params
    p auth_hash
    redirect_to new_user_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def set_session_id(user)
    session[:current_user_id] = user.id
  end
end
