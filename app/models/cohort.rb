class Cohort < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :display
  has_many :users
  has_many :commitments
  has_many :mentors, :through => :commitments, :source => :user
  validates_presence_of :name, :start_date, :end_date

  scope :active, where("end_date >= ?", Date.today)

  def mentor_night
    start_date + 1.day
  end

  def set_end_date
    self.end_date = self.start_date + 9.weeks
  end

  def self.next
    Cohort.where("start_date > ?", Time.now.to_date - 4.days).limit(1).first
  end

  def pairings
    Pairing.for_cohort(self.id)
  end

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
    end_date >= Date.today && start_date <= Date.today
  end

  def available_mentorships
    boots.count - mentors.count
  end

  def notify_pairs
    pairings.each do |pairing| 
      AdminMailer.notify_pair(pairing.mentor, pairing.mentee, name).deliver
    end
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
