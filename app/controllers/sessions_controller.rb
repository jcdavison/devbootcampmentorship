class SessionsController < ApplicationController
  def create
    if @authorization = Authorization.find_by_uid(auth_hash[:uid])
      session[:current_user_id] = @authorization.user.id 
      redirect_to root_path
    else
      @user = User.new
      @user.set_attributes(auth_hash, params[:role])
      if @user.save
        @user.new_auth(auth_hash, params[:role])
        session[:current_user_id] = @user.id 
        redirect_to root_path
      end
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
