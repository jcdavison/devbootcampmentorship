class Cohort < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date
  has_many :users

  def match_mentors
    puts "nothin"
  end
end
