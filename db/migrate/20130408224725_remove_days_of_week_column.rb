class RemoveDaysOfWeekColumn < ActiveRecord::Migration
  def self.up
    remove_column :meetings, :days_of_week
  end

  def self.down
    add_column :meetings, :days_of_week, :text
  end
end
