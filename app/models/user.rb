class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :pic, :role
  validates_presence_of :email, :first_name, :last_name

  has_many :authorizations, :dependent => :destroy

  def set_attributes(auth_hash)
    self.email = auth_hash[:info][:email]
    self.first_name = auth_hash[:info][:first_name]
    self.last_name = auth_hash[:info][:last_name]
    self.pic = auth_hash[:info][:image]
  end

  def new_auth(auth_hash)
    self.authorizations.build( provider: auth_hash[:provider], uid: auth_hash[:uid], token: auth_hash[:credentials][:token], secret: auth_hash[:credentials][:secret])
    self.save
  end

end
