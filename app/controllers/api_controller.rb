class ApiController < ApplicationController

  rescue_from CanCan::AccessDenied do
    head :forbidden
  end

end