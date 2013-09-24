require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://seattleaa.org/directory/outputt3x.php"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text