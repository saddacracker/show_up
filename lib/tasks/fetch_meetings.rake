namespace :meetings do
  namespace :fetch do 

    desc "Scrape Seattle Meetings"
    task :seattle => :environment do

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
        hall = hall.strip
        return @halls[hall]
      end

      days = %w[sunday monday tuesday wednesday thursday friday saturday]
      number = 0

      days.each do |day|
        url = "http://seattleaa.org/directory/web#{day}.html"
        doc = Nokogiri::HTML(open(url))

        doc.css('table tr').each do |item|

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
            
            # obvioussly we need an address if it's empty
            if address.empty?
              address = convert_empty_hall(name)
            end
            
            # check if the address supplied is actually the name of a hall and not really an address
            if @halls[address]
              address = @halls[address]
            end

            number = number+1

            # puts "CREATING: #{number} #{division} : #{time} - #{name} - #{address} - #{is_closed} - #{tags} - #{duration}"

            if @meetings.include? name
              temp_meetings = Meeting.where('title LIKE ?', "%#{name}%")
              temp_meetings.each do |m|
                m.update_attribute day.to_sym, 1
              end
              
              print "-"

            else 
              @meetings << name
              Meeting.create(:address => address, :week_days => {day => 1}, :duration => duration, :time => time, :closed_meeting => is_closed, :description => "No Description", :title => name, :tags => {})
              
              print "."
            end     

          end
        end
      end
    end

  end
end