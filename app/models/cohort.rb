class Cohort < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date
  has_many :users
  has_many :commitments
  has_many :mentors, :through => :commitments, :source => :user
  validates_presence_of :name, :start_date, :end_date

  def boots
    users
  end

  def match_all_mentors
    chosen_mentors = find_mentors
    match_mentors(chosen_mentors)
  end

  def find_mentors
    if mentors.count > boots.count
      reduce_mentors
    elsif mentors.count < boots.count
      duplicate_mentors
    else
      mentors
    end
  end

  def match_mentors(chosen_mentors)
    chosen_mentors.zip(boots).each { |mentor, boot| mentor.mentor!(boot) }
    inform_mentors(chosen_mentors)
    inform_boots
  end

  def inform_boots
    puts "This should email boots to tell them they have mentors"
  end

  def inform_mentors(chosen_mentors)
    puts "This should email chosen mentors"
  end

  def inform_unchosen_mentors(unchosen_mentors)
    puts "This should email unchosen mentors and encourage them to choose another cohort"
  end

  def duplicate_mentors
    puts "working"
  end

  def reduce_mentors
    possible_mentors = mentors
    chosen_mentors = possible_mentors.slice!(0, boots.count)
    inform_unchosen_mentors(possible_mentors)
    chosen_mentors
  end
end
