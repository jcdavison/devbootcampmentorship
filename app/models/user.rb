class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :pic, :role
  validates_presence_of :email, :first_name, :last_name

  has_many :authorizations, :dependent => :destroy
  belongs_to :cohort
  has_many :pairings, :foreign_key => "mentee_id", :dependent => :destroy
  has_many :reverse_pairings, :foreign_key => "mentor_id", :class_name => "Pairing", :dependent => :destroy
  has_many :mentors, :through => :pairings, :class_name => "User"
  has_many :mentees, :through => :reverse_pairings, :class_name => "User"
  has_many :commitments
  has_many :cohorts, :through => :commitments


  def set_attributes(auth_hash, opts = {})
    self.email = auth_hash[:info][:email]
    self.first_name = auth_hash[:info][:first_name]
    self.last_name = auth_hash[:info][:last_name]
    self.pic = auth_hash[:info][:image]
    self.cohort_id = opts[:cohort][:cohort_id] unless opts[:cohort].nil?
    self.contact_email = opts[:user][:email] unless opts[:user].nil?
  end

  def new_auth(auth_hash)
    self.authorizations.build( provider: auth_hash[:provider], uid: auth_hash[:uid], token: auth_hash[:credentials][:token], secret: auth_hash[:credentials][:secret])
    self.save
  end

  def mentor!(other_user)
    Pairing.create!(:mentor_id => id, :mentee_id => other_user.id)
  end

  def commit_to_mentor!(cohort)
    Commitment.create!(:user_id => id, :cohort_id => cohort.id)
  end

  def boot_status
    if cohort.try(:end_date) > Date.today
      "Boot"
    elsif cohort.try(:end_date) < Date.today
      "Alumni"
    end
  end
end
