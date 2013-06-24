class MainController < ApplicationController
  before_filter :admin?
  def index
  end
end
