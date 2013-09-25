require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'time'



def change_the_case(name)
  name.downcase
  name.gsub(/\w+/) do |word|
    word.capitalize
  end
end

def clean_the_time(timey)
  timey = timey.downcase
  timey == "noon" ? timey = "12:00 pm" : timey = timey;
  timey == "midnight" ? timey = "12:00 am" : timey = timey;
  
  timey = Time.parse(timey)
  military_format = timey.strftime("%H%M")
end

days = %w[sunday monday tuesday wednesday thursday friday saturday]
number = 0

days.each do |day|
  url = "http://seattleaa.org/directory/web#{day}.html"
  doc = Nokogiri::HTML(open(url))
  
  puts "\n ::::::: #{day.capitalize} ::::::: \n\n"

  doc.css('table tr').each do |item|
    # @TODO: convert halls to addresses
    # @TODO: convert their tags to my tag and create hash (hstore compliant)
    # @TODO: check for matching title (update day of week hash, if so)
    
    if  item.at_css("td")
      division  = item.at_css("td").text
      time      = clean_the_time(item.at_css("td + td").text)
      is_closed = item.at_css("td + td + td").text
      name      = change_the_case(item.at_css("td + td + td + td").text)
      address   = item.at_css("td + td + td + td + td").text
      tags      = item.at_css("td + td + td + td + td + td").text 
      # duration  = tags.gsub!('oh',' ')
      
      # check if there is 'oh' (one-hour) in the tags
      if tags.gsub!('oh',' ').nil?
        duration = 90
      else 
        duration = 60
      end
      
      # convert is_closed
      is_closed == "C" ? is_closed = true : is_closed = false
        
      
      number = number+1

      puts "#{number} #{division} : #{time} - #{name} - #{address} - #{is_closed} - #{tags} - #{duration}"
    end
  end
end







