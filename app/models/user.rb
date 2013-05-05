class User < ActiveRecord::Base
  validates_presence_of :email, :first_name, :last_name, :role

  has_many :authorizations

end
