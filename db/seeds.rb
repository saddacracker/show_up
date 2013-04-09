# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create a user
User.create({ :email => 'admin@example.com', :password => 'password', :password_confirmation => 'password'})


#create some meetings
meetings = Meeting.create([
{:address => '99 Ferry St. Easthampton, MA', :week_days => {"friday"=>"0", "monday"=>"0", "sunday"=>"0", "tuesday"=>"0", "saturday"=>"0", "thursday"=>"1", "wednesday"=>"1"}, :duration => 100, :time => 1200, :title => 'Sample Meeting', :tags => {"speaker"=>"1", "childcare"=>"0", "book_study"=>"0"}},

{:address => '45 Mereline Ave. Eastlongmeadow, MA', :week_days => {"friday"=>"1", "monday"=>"1", "sunday"=>"1", "tuesday"=>"0", "saturday"=>"0", "thursday"=>"1", "wednesday"=>"1"}, :duration => 100, :time => 1200, :title => 'Sample Meeting 2', :tags => {"speaker"=>"1", "childcare"=>"1", "book_study"=>"1"}}
])
