class Commitment < ActiveRecord::Base
  attr_accessible :cohort_id, :user_id, :email
  belongs_to :user
  belongs_to :cohort
  def email

  end
end
