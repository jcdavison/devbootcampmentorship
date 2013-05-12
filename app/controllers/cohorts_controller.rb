class CohortsController < ApplicationController
  def show
    @cohort = Cohort.find(params[:id])
  end
end
