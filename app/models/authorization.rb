class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :token, :secret
  belongs_to :user

  def update_info(auth_hash, role)
    self.update_attributes(provider: auth_hash[:provider], uid: auth_hash[:uid], token: auth_hash[:credentials][:token], secret: auth_hash[:credentials][:secret]) 
    self.user.update_attributes( email: auth_hash[:info][:email], first_name: auth_hash[:info][:first_name], last_name: auth_hash[:info][:last_name], pic: auth_hash[:info][:image])
  end

  def self.create_auth(auth_hash, user_id)
    Authorization.create(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid],
      user_id: user_id,
      email: auth_hash[:info][:email],
      token: auth_hash[:token],
      token: auth_hash[:secret])
  end
end
