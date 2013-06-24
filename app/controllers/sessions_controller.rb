class SessionsController < ApplicationController
  def new

  end

  def create
    @authorization = Authorization.find_by_uid(auth_hash[:uid])
    @authorized_user = @authorization.user if @authorization
    @user = User.find_by_email auth_hash[:info][:email]
    if @authorized_user
      set_session_id @authorized_user
      redirect_to main_index_path
    elsif @user
      Authorization.create_auth(auth_hash, @user.id)
      set_session_id @user
      redirect_to main_index_path
    else
      redirect_to '/sign_up'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def set_session_id(user)
    session[:current_user_id] = user.id
  end
end
