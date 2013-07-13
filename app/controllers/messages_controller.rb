class MessagesController < ApplicationController
  before_filter :protect_admin

  def new

  end

  def create
    redirect_to :back
  end

end
