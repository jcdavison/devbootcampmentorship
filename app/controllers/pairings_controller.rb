class PairingsController < ApplicationController
  before_filter :is_admin?

  def update
    binding.pry
    @pairing = Pairing.new(params[:pairing])
    if @pairing.save
      redirect_to cohort_path(params[:id])
    else
      redirect_to :back
    end
  end
end
