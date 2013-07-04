class CommitmentsController < ApplicationController
  before_filter :protect_admin
  def destroy
    Commitment.find_by_user_id(params[:id]).destroy
    redirect_to :back
  end

  def create
    user = User.find_by_email(params[:commitment][:email])
    cohort_id = params[:cohort][:id]
    redirect_to :back unless user && cohort_id
    Commitment.create(
      cohort_id: cohort_id,
      user_id: user.id)
    redirect_to :back
  end
end
