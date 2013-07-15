class CohortsController < ApplicationController
  respond_to :html, :json
  before_filter :protect_admin
  before_filter :find_cohort, only: [:notify]

  def show
    @cohort = Cohort.find_by_id(params[:id])
    @mentors = @cohort.mentors
    @boots = @cohort.boots
    @pairing = Pairing.new
    @commitment = Commitment.new
    @cohorts = Cohort.all
  end

  def index
    @cohorts = Cohort.all
    @commitment = Commitment.new
    @cohort = Cohort.new
  end

  def update

  end

  def message_cohort
    #message all mentors, all mentees, all members
  end

  def notify
    if params[:cohort_id]
      @cohort = Cohort.find(params[:cohort_id])
      @cohort.notify_pairs
    elsif params[:pairing_id]
      Pairing.notify_pair(params[:pairing_id])
    end
    redirect_to :back
  end

  def create
    @cohort = Cohort.new(params[:cohort])
    @cohort.set_end_date
    @cohort.save
    redirect_to :back
  end

  def destroy
    Cohort.find_by_id(params[:id]).destroy
    redirect_to :back
  end

  private

  def find_cohort
    @cohort = Cohort.find_by_id(params[:cohort_id])
  end

end
