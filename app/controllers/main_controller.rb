class MainController < ApplicationController
  before_filter :protect_admin
  def index
    @active_cohorts = Cohort.active
  end
end
