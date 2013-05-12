class Commitment < ActiveRecord::Base
  attr_accessible :cohort_id, :user_id
  belongs_to :user
  belongs_to :cohort
end
