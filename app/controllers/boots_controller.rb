class BootsController < ApplicationController
  def edit
    @boot = User.find(current_user.id)
  end
end
