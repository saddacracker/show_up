module MeetingsHelper
  
  def am_pm_hour_select(object, method, options = {}, html_options = {})
    select_options = create_hours(:start_time => 5.hours, :end_time => 23.hours)

    unless options[:start].nil?
      shift_if_needed = Proc.new{|hour, start| hour<start ? hour+24 : hour}
      select_options.sort!{|x, y| shift_if_needed.call(x.last,options[:start]) <=> shift_if_needed.call(y.last, options[:start]) }
    end

    object.select(method, select_options, options = {}, html_options = {})
  end
  
  # http://stackoverflow.com/questions/2286716/filling-a-select-with-a-series-of-times-in-increments-plus-additional-options
  def create_hours(parameters)
    start_time = parameters[:start_time] ? parameters[:start_time] : 0
    end_time = parameters[:end_time] ? parameters[:end_time] : 24.hours
    increment = parameters[:increment] ? parameters[:increment] : 15.minutes
    
    Array.new(1 + (end_time - start_time)/increment) do |i|
      ampm_format     = (Time.now.midnight + (i*increment) + start_time).strftime("%I:%M %p") 
      military_format = (Time.now.midnight + (i*increment) + start_time).strftime("%H%M")
      
      time_options = Array.new
      time_options.push ampm_format
      time_options.push military_format.to_i
      
      time_options
    end
    
    # [ ["7:00 PM", 1900], ["7:30 PM", 1930], ["7:45 PM", 1945], ["8:00 PM", 2000] ]
  end
  
end
