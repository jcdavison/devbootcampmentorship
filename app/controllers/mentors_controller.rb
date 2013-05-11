class MentorsController < ApplicationController
  def edit
    @mentor = User.find(params[:id])
  end

  def update
  end
end
