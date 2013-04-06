class Meeting < ActiveRecord::Base
  attr_accessible :address, :closed_meeting, :days_of_week, :description, :duration, :latitude, :longitude, :tags, :time, :title
  
  validates_presence_of :address, :duration, :days_of_week, :tags, :time, :title
  validates_numericality_of :time, :duration
  
  serialize :days_of_week , Hash
  serialize :tags         , Hash

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
