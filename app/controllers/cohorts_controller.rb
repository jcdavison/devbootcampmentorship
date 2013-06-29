class CohortsController < ApplicationController
  before_filter :is_admin?
  def show
    @cohort = Cohort.find(params[:id])
    @mentors = @cohort.mentors
    @boots = @cohort.boots
    @pairing = Pairing.new
  end

  def index
    @cohorts = Cohort.all
  end

  def update

  end

end
