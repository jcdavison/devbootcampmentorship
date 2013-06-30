class Pairing < ActiveRecord::Base
  attr_accessible :mentee_id, :mentor_id
  belongs_to :mentor, :class_name => "User"
  belongs_to :mentee, :class_name => "User"

  scope :for_cohort, lambda{|cohort_id|
    joins("inner join users u on u.id = pairings.mentee_id").
    joins("inner join cohorts c on c.id = u.cohort_id").
    where("c.id = #{cohort_id}").
    select("pairings.*")
  }
end