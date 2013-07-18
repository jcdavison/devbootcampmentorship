class MentorsController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def next_steps

  end

  def thanks
    @user = User.find(params[:id])
    if current_user
      redirect_to edit_user_path(@user)
    end
  end
end
