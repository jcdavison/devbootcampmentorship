class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :pic, :role, :contact_phone, :contact_email, :twitter, :linkedin, :interests, :passions, :location_id, :company, :repo, :employment_agreement, :admin, :cohort_id
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
  belongs_to :location


  MESSAGE_LIST = ["all_mentors", "all_current_boots", "all_alum_and_boots", "all_users"]
  COHORT_LIST = ["all_mentors", "all_mentees", "all_members"]

  def self.send_messages(message)
    list = message[:list_name]
    users = User.all_mentors if list  == MESSAGE_LIST[0]
    users = User.all_current_boots if list == MESSAGE_LIST[1]
    users = User.all_alum_and_boots if list == MESSAGE_LIST[2]
    users = User.all_users if list == MESSAGE_LIST[3]
    emails = User.emails(users)
    return unless emails
    emails.each do |email|
      user = User.find_by_email(email)
      mail = AdminMailer.send_message(message, user)
      mail.deliver if mail
    end
  end

  def admin?
    if admin == true
      true
    else
      false
    end
  end
  def self.recent
    where(created_at: (Time.now - 14.days)..Time.now)
  end

  def self.all_mentors
    all.select {|user| user.avail_mentor? }
  end

  def self.all_users
    all
  end

  def self.all_current_boots
    all.select {|user| user.boot_status == "Boot" }
  end

  def self.all_alum_and_boots
    all.select do |user|
      user.boot_status == "Boot" ||
        user.boot_status == "alumni"
    end
  end
  def self.recent_boot
    recent.select {|u| u.boot_status == ("Alumni" || "Boot") }
  end

  def self.recent_mentors
    recent.select {|u| u.avail_mentor? }
  end

  def full_name
    first_name + " " + last_name
  end

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
    return unless self.cohort
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

  def assign_next_cohort
    unless boot_status == "Boot"
      commit_to_mentor!(Cohort.next)
    end
  end

  def self.process_wufoo_user(user)
    users = []
    errors = []
    opts = wufoo_opts(user)
    u = User.new(opts)
    u.email = "user_#{User.last.id + 1}_email@devbootcamp.com" if u.email.nil?
    return if email_taken?(u)
    u.first_name = "temporary_name" if u.first_name.nil?
    u.save!
    puts "User: #{u.id} given a temporary email!" if opts[:email].nil?
    puts "User: #{u.id} given a temporary first name!" if opts[:first_name].nil?
  end

  def self.email_taken?(user)
    find_by_email(user.email).present?
  end

  def self.wufoo_opts(user)
    opts = {}
    opts[:first_name] = user["Field1"] unless user["Field1"].blank?
    opts[:last_name] = user["Field530"] unless user["Field530"].blank?
    opts[:email] = user["Field3"].downcase unless user["Field3"].blank?
    opts[:company] = user["Field315"] unless user["Field315"].blank?
    opts[:linkedin] = user["Field527"] unless user["Field527"].blank?
    opts[:twitter] = user["Field636"] unless user["Field636"].blank?
    opts[:location_id] = Location.find_by_name(user["Field525"]) unless user["Field525"].blank?
    opts[:passions] = user["Field535"] unless user["Field535"].blank?
    opts[:interests] = user["Field208"] unless user["Field208"].blank?
    opts
  end

  def self.emails(users)
    users.map(&:email)
  end
end
