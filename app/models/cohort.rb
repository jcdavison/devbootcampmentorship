class Cohort < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :display
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
    inform_mentors(chosen_mentors)
    inform_boots
  end

  def active?
    self.end_date >= Date.today
  end

  def available_mentorships
    boots.count - mentors.count
  end

  private

  def find_mentors
    if mentors.count > boots.count
      reduce_mentors
    elsif mentors.count < boots.count
      mentors
    else
      mentors
    end
  end

  def match_mentors(chosen_mentors)
    unmentored_boots = boots
    while unmentored_boots.count >= chosen_mentors.count
      chosen_mentors.zip(unmentored_boots).each do |mentor, boot|
        mentor.try(:mentor!, boot)
        unmentored_boots -= [boot]
      end
    end
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

  def reduce_mentors
    possible_mentors = mentors
    chosen_mentors = possible_mentors.slice!(0, boots.count)
    inform_unchosen_mentors(possible_mentors)
    chosen_mentors
  end
end
