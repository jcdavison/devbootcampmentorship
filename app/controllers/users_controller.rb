class UsersController < ApplicationController
  def new_mentor
    @user = User.new
    @locations = Location.all
  end

  def new_boot
    @user = User.new
    @locations = Location.all
  end

  def index
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.assign_next_cohort
      AdminMailer.welcome(@user).deliver
      redirect_to thank_you_path(id: @user.id)
    else
      redirect_to :back
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
    @locations = Location.all
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update_attributes(params[:user])
    redirect_to edit_user_path(@user)
  end
  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def set_session_id(user)
    session[:current_user_id] = user.id
  end
end
