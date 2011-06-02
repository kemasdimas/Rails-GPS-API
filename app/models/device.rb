class Device < ActiveRecord::Base
  has_many :gps_statuses, :dependent => :destroy
  
  validates_uniqueness_of :device_code
end