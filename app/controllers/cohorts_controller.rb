class CohortsController < ApplicationController
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
    @cohort.notify_pairs
  end

  private

  def find_cohort
    @cohort = Cohort.find_by_id(params[:cohort_id])
  end

end
