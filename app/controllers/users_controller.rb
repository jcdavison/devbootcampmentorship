class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = User.find_by_email(auth_hash[:email]) && @authorization = Authorization.find_by_uid(auth_hash[:uid])
      session[:current_user_id] = @authorization.user.id 
      route_user(@user)
    elsif @user = User.find_by_email(auth_hash[:email])
      @user.new_auth(auth_hash) 
      route_user(@user)
      # redirect_to edit_mentor_path @user if @user.avail_mentor? && @user.mentees.empty?
      # redirect_to edit_boot_path @user if ! @user.avail_mentor?
    elsif
      @user = User.new
      @user.set_attributes(auth_hash, params)
      session[:current_user_id] = @user.id if @user.save 
      @user.new_auth(auth_hash)
      route_user(@user)
      # redirect_to edit_mentor_path @user if @user.avail_mentor? && @user.mentees.empty?
      # redirect_to edit_boot_path @user if ! @user.avail_mentor?
      # redirect_to cohort_path current_user.cohort.id if @user.mentor? == "busy"
      # redirect_to cohort_path current_user.cohort.id 
    elsif
      redirect_to sign_in_path
    end
  end

  def update
    User.find(params[:id]).update_attributes(params[:user])
    redirect_to cohorts_path 
  end
  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def set_session_id(user)
    session[:current_user_id] = user.id
  end
end
