class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :pic, :role, :contact_phone, :contact_email, :twitter, :linkedin, :interests, :passions, :location, :company, :repo, :employment_agreement, :admin
  validates_presence_of :email, :first_name
  validates_uniqueness_of :email

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
    self.contact_email = self.email 
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

  def avail_mentor?
    (cohort && cohort.active?) ? false : true
  end

  def admin!
    self.admin = true
  end

  def self.process_wufoo_user(user)

    return if user["Field3"].empty?

    if User.find_by_email(user["Field3"])
      p "user #{user["Field3"]} already exists"
      return
    else
      user = User.new(
        first_name: user["Field1"],
        last_name: user["Field530"],
        email: user["Field3"] || "example@example.com",
        company: user["Field315"],
        linkedin: user["Field527"],
        twitter: user["Field636"],
        location: user["Field525"],
        passions: user["Field535"],
        interests: user["Field208"]
      )
      p user.save!
    end
  end
end
