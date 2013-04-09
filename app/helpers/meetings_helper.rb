module MeetingsHelper
  
  def am_pm_hour_select(object, method, options = {}, html_options = {})
    select_options = create_hours(:start_time => 5.hours, :end_time => 23.hours)
    # select_options = [ ["6am", 6], ["7am", 7], ["8am", 8], ["9am", 9], ["10am", 10], ["11am", 11], ["12pm", 12], ["1pm", 13], ["2pm", 14], ["3pm", 15], ["4pm", 16], ["5pm", 17], ["6pm", 18], ["7pm", 19], ["8pm", 20], ["9pm", 21], ["10pm", 22], ["11pm", 23], ["12am", 24], ["1am", 1], ["2am", 2], ["3am", 3], ["4am",4 ], ["5am", 5]]
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
      # Array.new( ampm_format + ", " + military_format )
      array = Array.new
      array.push ampm_format
      array.push military_format.to_i
      
      array
    end
    
    # ["05:30 AM", "06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM", "08:00 AM", 
    #     "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", 
    #     "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM", "02:00 PM", 
    #     "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM", 
    #     "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM", "08:00 PM", 
    #     "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM"]
  end
  
end
