require 'rubygems'
require 'nokogiri'
require 'open-uri'

days = %w[sunday monday tuesday wednesday thursday friday saturday]

days.each do |day|
  url = "http://seattleaa.org/directory/web#{day}.html"
  doc = Nokogiri::HTML(open(url))

  doc.css('table tr').each do |item|
    # puts item.content
    if  item.at_css("td")
      division  = item.at_css("td").text
      time      = item.at_css("td + td").text
      is_closed = item.at_css("td + td + td").text
      name      = item.at_css("td + td + td + td").text.capitalize
      address   = item.at_css("td + td + td + td + td").text
      tags      = item.at_css("td + td + td + td + td + td").text 

      puts "#{time} - #{name} - #{address} - #{is_closed} - #{division} - #{tags}"
    end
  end
end



