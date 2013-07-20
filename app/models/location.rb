class Location < ActiveRecord::Base
  attr_accessible :name
  has_many :users
  has_many :cohorts
  validates_presence_of :name

  def to_s
    name
  end
end
