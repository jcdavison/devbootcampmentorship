class CohortsController < ApplicationController
  before_filter :is_admin?
  def show
    @cohort = Cohort.find(params[:id])
  end

  def index
    @cohorts = Cohort.all
  end


end
