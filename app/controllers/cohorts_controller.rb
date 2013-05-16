class CohortsController < ApplicationController
  def show
    @cohort = Cohort.find(params[:id])
  end

  def index
    @cohorts = Cohort.all
  end
end
