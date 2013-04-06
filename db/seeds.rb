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
{:address => '99 Ferry St. Easthampton, MA', :days_of_week => {"mon"=>"1", "tue"=>"0", "wed"=>"0", "thu"=>"0", "fri"=>"0", "sat"=>"0", "sun"=>"0"}, :duration => 2, :time => 19, :title => 'Test Meeting', :tags => {"speaker"=>"1", "gay"=>"0", "childcare"=>"0", "mens"=>"0", "womens"=>"1", "book_study"=>"0", "step_study"=>"0"}},  

{:address => '1827 McDougall Ave. Everett, WA', :days_of_week => {"mon"=>"1", "tue"=>"0", "wed"=>"0", "thu"=>"0", "fri"=>"0", "sat"=>"0", "sun"=>"0"}, :duration => 1, :time => 19, :title => 'New Life', :tags => {"speaker"=>"1", "gay"=>"0", "childcare"=>"0", "mens"=>"1", "womens"=>"0", "book_study"=>"0", "step_study"=>"0"}},

{:address => '5024 161st PL SW Edmonds, WA', :days_of_week => {"mon"=>"1", "tue"=>"0", "wed"=>"0", "thu"=>"0", "fri"=>"0", "sat"=>"0", "sun"=>"0"}, :duration => 1, :time => 19, :title => '13th Step Group', :tags => {"speaker"=>"1", "gay"=>"0", "childcare"=>"1", "mens"=>"0", "womens"=>"0", "book_study"=>"0", "step_study"=>"0"}},

{:address => 'Everett and Hoyt Everett, WA', :days_of_week => {"mon"=>"0", "tue"=>"0", "wed"=>"0", "thu"=>"1", "fri"=>"0", "sat"=>"0", "sun"=>"0"}, :duration => 1, :time => 19, :title => 'A Vision For Yo Mammy', :tags => {"speaker"=>"1", "gay"=>"0", "childcare"=>"0", "mens"=>"0", "womens"=>"0", "book_study"=>"0", "step_study"=>"0"}}
])
