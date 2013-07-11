class MessagesController < ApplicationController
  before_filter :protect_admin

  def new
    @message = Message.new

  end

  def create

  end

end
