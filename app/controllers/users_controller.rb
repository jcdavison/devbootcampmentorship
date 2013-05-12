class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @authorization = Authorization.find_by_uid(auth_hash[:uid])
      session[:current_user_id] = @authorization.user.id 
      redirect_to cohort_path current_user.cohort
    elsif
      @user = User.new
      @user.set_attributes(auth_hash, params)
      session[:current_user_id] = @user.id if @user.save 
      redirect_to cohort_path current_user.cohort.id 
    elsif
      redirect_to sign_in_path
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def set_session_id(user)
    session[:current_user_id] = user.id
  end
end
