class MentorsController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def next_steps

  end
end
