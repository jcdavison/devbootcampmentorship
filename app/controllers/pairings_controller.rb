class PairingsController < ApplicationController
  before_filter :protect_admin

  def create
    @pairing = Pairing.new(params[:pairing])
    if @pairing.save
      redirect_to :back 
    else
      redirect_to :back
    end
  end

  def update
  end

  def destroy
    redirect_to :back unless params[:id]
    @pairing = Pairing.find_by_id(params[:id])
    @pairing.notify_pair_destruction(@pairing.id)
    @pairing.destroy
    redirect_to :back
  end
end
