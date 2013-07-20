class MainController < ApplicationController
  load_and_authorize_resource
  def index
    @active_cohorts = Cohort.active
  end
end
