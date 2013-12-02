require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'time'

@meetings = Array.new 
@halls = {
  "Ed Lynn Fellowship" => "5800 198th SW, Suite 1, Lynnwood 98036",
  "Pass It On - 17801 1st Ave S 98148" => "17801 1st Ave S 98148",
  "Serenity Hall" => "12536 Renton Ave South, Renton 98178",
  "Southend Fellowship" => "321 3rd Ave South, Kent 98032",
  "12 & 12 Fellowship" => "23732 Bothell Everett Hwy Bothell, WA 98021",
  "Pass It On -17801 1st Ave S 98148" => "17801 1st Ave S 98148",
  "A New Beginning" => "15403 Ambaum Blvd S.W., Burien 98166",
  "Lynnwood Alano Club" => "4001 198th Street SW, Lynnwood 98036",
  "Phoenix Club" => "15011 Aurora Ave N, Seattle",
  "Fremont Fellowship Hall" => "8916 Aurora Avenue North, Seattle 98103",
  "Cherry Fellowship" => "2701 East Cherry, Seattle 98122",
  "South King Alano Club" => "1317 Harvey Road, Auburn 98002",
  "South County Alano Club" => "1317 Harvey Road, Auburn 98002",
  "Alano Club of the Eastside" => "12302 NE 8th, Bellevue 98005",
  "Eastside Alano Club" => "12302 NE 8th, Bellevue 98005",
  "12 & 12 Fellowship" => "23732 Bothell-Everett Highway",
  "12 & 12 Study" => "23732 Bothell-Everett Highway",
  "12 & 12 FELLOWSHIP" => "23732 Bothell-Everett Highway",
  }

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

def convert_tags(tags)
  # an at cc gs mo oh si sp ss wb we wo wp yp
  # unless tags.nil?
  #     tags = tags[1..-2].split(' ').collect! {|n| n} 
  #   end
end

def convert_empty_hall(hall)
  
  # Alano Club Of The Eastside 
  # 12302 NE 8th, Bellevue 98005
  
  # Capital Hill Alano Club
  
  # Ed Lynn Fellowship
  # 5800 198th SW, Suite 1, Lynnwood 98036
  
  # Fremont Fellowship Hall
  # 8916 Aurora Avenue North, Seattle 98103
  
  # Lynnwood Alano Club
  # 4001 198th Street SW, Lynnwood 98036
  
  # A New Beginning
  # 15403 Ambaum Blvd S.W., Burien 98166
  
  # The Phoenix Club
  # 15011 Aurora Ave N, Seattle
  
  # Serenity Hall
  # 12536 Renton Ave South, Renton 98178
  
  # Groups at the South County Alano Club
  # 1317 Harvey Road, Auburn 98002
  
  # Southend Fellowship 
  # 321 - 3rd Ave South, Kent 98032
  
  # 12 & 12 Fellowship
  # 23732 Bothell-Everett Highway
  
  # Cherry Fellowship
  # 2701 East Cherry, Seattle 98122
  
  
  # adding addresses to halls missing addresses from the scraped website  
  # correct_halls = [{
  #   "Ed Lynn Fellowship" => "5800 198th SW, Suite 1, Lynnwood 98036",
  #   "Pass It On - 17801 1st Ave S 98148" => "17801 1st Ave S 98148",
  #   "Serenity Hall" => "12536 Renton Ave South, Renton 98178",
  #   "Southend Fellowship" => "321 3rd Ave South, Kent 98032",
  #   "12 & 12 Fellowship" => "23732 Bothell Everett Hwy Bothell, WA 98021",
  #   "Pass It On -17801 1st Ave S 98148" => "17801 1st Ave S 98148",
  #   "A New Beginning" => "15403 Ambaum Blvd S.W., Burien 98166",
  #   }]
  
  # unless @halls.include? hall
  #   @halls << hall
  #   print hall
  # end
  
  hall = hall.strip
  
  return @halls[hall]
  
  
end

def convert_hall_to_address(hall)
  
  # Lynnwood Alano Club
  # Phoenix Club
  # Fremont Fellowship Hall
  # Cherry Fellowship
  # South King Alano Club
  # South County Alano Club
  # Alano Club of the Eastside
  # Eastside Alano Club
  # 12 & 12 Fellowship
  # 12 & 12 Study
  # 12 & 12 FELLOWSHIP
  # South County Alano Club
  # South King Alano Club
  
  hall = hall.strip
  
  return @halls[hall] 
  
end

days = %w[sunday monday tuesday wednesday thursday friday saturday]
number = 0

days.each do |day|
  url = "http://seattleaa.org/directory/web#{day}.html"
  doc = Nokogiri::HTML(open(url))
  
  # puts "\n ::::::: #{day.capitalize} ::::::: \n\n"

  doc.css('table tr').each do |item|
    # 1) @TODO: convert clubs and halls to addresses
    # 3) @TODO: convert their tags to my tag and create hash (hstore compliant)
    # 2) @TODO: check for matching title (update day of week hash, if so)
    
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
      
      # convert the rest of the tags
      convert_tags(tags)
      
      # convert is_closed
      is_closed == "C" ? is_closed = true : is_closed = false
      
      if address.empty?
        address = convert_empty_hall(name)
      end
      
      # if @halls.key(address)
      #   puts address
      #   # address = convert_hall_to_address(address)
      #   # puts address
      # end
      
      number = number+1

      # puts "CREATING: #{number} #{division} : #{time} - #{name} - #{address} - #{is_closed} - #{tags} - #{duration}"
      
      if @meetings.include? name
        puts "UPDATING: #{address}"
        # http://apidock.com/rails/ActiveRecord/Relation/update_all
        # Meeting.where('title LIKE ?', "%#{name}%").update(:week_days => {:friday => 0, :monday => 0, :sunday => 0, :tuesday => 0, :saturday => 0, :thursday => 0, :wednesday => 0})
        
        # temp_meetings = Meeting.where('title LIKE ?', "%#{name}%")
        #         # m = m.first
        #         temp_meetings.each do |m|
        #           m.update_attribute day.to_sym, 1
        #         end
        
      
      else 
        puts "CREATING: #{address}"
        @meetings << name
        #        Meeting.create(:address => address, :week_days => {day => 1}, :duration => duration, :time => time, :closed_meeting => is_closed, :description => "No Description", :title => name, :tags => {})
        
        
        # http://ruby.jieck.com/blog/2013/03/19/nosqlize-postgresql-with-hstore-in-rails-3.2plus/
        # Meeting.create(:address => "100 Testickle Ave. Easthampton, MA", :week_days => {"monday"=>"1"}, :duration => 90, :time => 1200, :closed_meeting => true, :description => "No Description", :title => "Test Scaper", :tags => {})
      end     

    end
  end
end







