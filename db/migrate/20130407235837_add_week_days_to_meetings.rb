class AddWeekDaysToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :week_days, :hstore
  end
end
