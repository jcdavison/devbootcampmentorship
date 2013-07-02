class CohortsController < ApplicationController
  respond_to :html, :json
  before_filter :is_admin?
  before_filter :find_cohort, only: [:notify]

  def show
    @cohort = Cohort.find_by_id(params[:id])
    @mentors = @cohort.mentors
    @boots = @cohort.boots
    @pairing = Pairing.new
  end

  def index
    @cohorts = Cohort.all
  end

  def update

  end

  def notify
    if params[:cohort_id]
      @cohort = Cohort.find(params[:cohort_id])
      @cohort.notify_pairs
    elsif params[:pairing_id]
      Pairing.notify_pair(params[:pairing_id])
    end
    redirect_to :back
  end

  private

  def find_cohort
    @cohort = Cohort.find_by_id(params[:cohort_id])
  end

end
