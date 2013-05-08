class MainController < ApplicationController
  before_filter :user_access?
  def index
  end
end
