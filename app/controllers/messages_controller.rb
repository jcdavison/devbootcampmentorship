class MessagesController < ApplicationController
  before_filter :protect_admin

  def new
  end

  def create
    message = params[:message]
    if params[:message_cohort]
      @cohort = Cohort.find(params[:cohort_id])
      @cohort.send_messages(message)
    else
      User.send_messages(message)
    end
    redirect_to :back
  end

end
