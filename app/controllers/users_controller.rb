class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to thank_you_path(id: @user.id)
    else
      redirect_to sign_up_path
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
