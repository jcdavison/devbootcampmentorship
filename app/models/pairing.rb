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

  def self.notify_pair(pairing_id)
    pairing = Pairing.find_by_id(pairing_id)
    AdminMailer.notify_pair(pairing.mentor, pairing.mentee, name).deliver
  end

  def self.notify_pair_destruction(pairing_id)
    pairing = Pairing.find_by_id(pairing_id)
    AdminMailer.notify_pair_destruction(pairing.mentor, pairing.mentee, name).deliver
  end
end
