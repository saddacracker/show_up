require 'rubygems'
require 'nokogiri'
require 'open-uri'



def change_the_case(name)
  name.downcase
  name.gsub(/\w+/) do |word|
    word.capitalize
  end
end

days = %w[sunday monday tuesday wednesday thursday friday saturday]
number = 0

days.each do |day|
  url = "http://seattleaa.org/directory/web#{day}.html"
  doc = Nokogiri::HTML(open(url))
  
  puts "\n ::::::: #{day.capitalize} ::::::: \n\n"

  doc.css('table tr').each do |item|
    
    if  item.at_css("td")
      division  = item.at_css("td").text
      time      = item.at_css("td + td").text
      is_closed = item.at_css("td + td + td").text
      name      = item.at_css("td + td + td + td").text
      name      = change_the_case(name)
      address   = item.at_css("td + td + td + td + td").text
      tags      = item.at_css("td + td + td + td + td + td").text 
      duration  = tags.gsub!('oh',' ')
      
      # check if there is 'oh' (one-hour) in the tags
      if duration.nil?
        duration = 90
      else 
        duration = 60
      end
      
      number = number+1

      puts "#{number}    #{time} - #{name} - #{address} - #{is_closed} - #{division} - #{tags} - #{duration}"
    end
  end
end







