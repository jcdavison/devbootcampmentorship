class UsersController < ApplicationController
  def new
    @user = User.new
    @locations = [ "San Francisco", "Chicago"]
  end

  def index
  end

  def create
    @user = User.new(params[:user])
    @user.location = params[:location]
    if @user.save

      redirect_to thank_you_path(id: @user.id)
    else
      redirect_to :back
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
