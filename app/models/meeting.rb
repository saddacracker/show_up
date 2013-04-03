class Meeting < ActiveRecord::Base
  attr_accessible :address, :closed_meeting, :days_of_week, :description, :duration, :latitude, :longitude, :tags, :time, :title
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
