class MainController < ApplicationController
  before_filter :is_admin?
  def index
    @active_cohorts = Cohort.active
  end
end
