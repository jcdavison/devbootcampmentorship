class SessionsController < ApplicationController
  def create
    p params
    if @authorization = Authorization.find_by_uid(auth_hash[:uid])
      session[:current_user_id] = @authorization.user.id 
      redirect_to edit_boot_path current_user.id if current_user.role = "boot" 
      redirect_to edit_mentor_path current_user.id if current_user.role = "mentor" 
    else
      @user = User.new
      @user.set_attributes(auth_hash)
      if params[:role] == "mentor" 
        @user.role = params[:role]
        @user.save
        redirect_to edit_mentor_path @user
      elsif @user.save
        @user.new_auth(auth_hash)
        session[:current_user_id] = @user.id 
        redirect_to edit_boot_path current_user.id if current_user.role = "boot" 
      else
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
