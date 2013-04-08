class Meeting < ActiveRecord::Base
  attr_accessible :address, :closed_meeting, :description, :duration, :latitude, :longitude, :time, :title
  
  # loop thru and create the accessor methods for week_days hstore!
  # (http://railscasts.com/episodes/345-hstore?view=asciicast)
  %w[monday tuesday wednesday thursday friday saturday sunday].each do |key|
    attr_accessible key
    
    # add scope for Meeting.has_monday("1")
    scope "has_#{key}", lambda { |value| where("week_days @> (? => ?)", key, value) }

    define_method(key) do
      week_days && week_days[key]
    end

    define_method("#{key}=") do |value|
      self.week_days = (week_days || {}).merge(key => value)
    end
  end
  
  validates_presence_of :address, :duration, :time, :title
  validates_numericality_of :time, :duration
  
  serialize :week_days    , ActiveRecord::Coders::Hstore

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

end
