class SessionsController < ApplicationController
  def new

  end

  def create
    @authorization = Authorization.find_by_uid(auth_hash[:uid])
    @authorized_user = @authorization.user if @authorization

    user_id = params[:user_id]
    email = auth_hash[:info][:email]
    @user = User.find_by_id(user_id) || User.find_by_email(email)

    if @authorized_user
      set_session_id @authorized_user
      route_user(@authorized_user)
    elsif @user
      Authorization.create_auth(auth_hash, @user.id)
      set_session_id(@user)
      route_user(@user)
    else
      redirect_to root_path
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

  def route_user(user)
    if user.admin?
      redirect_to cohorts_path
    else
      redirect_to thank_you_path(id: user.id)
    end
  end
end
