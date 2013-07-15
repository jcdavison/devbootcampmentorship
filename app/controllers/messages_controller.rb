class MessagesController < ApplicationController
  before_filter :protect_admin

  def new
  end

  def create
    message = params[:message]
    User.send_messages(message)
    redirect_to :back
  end

end
