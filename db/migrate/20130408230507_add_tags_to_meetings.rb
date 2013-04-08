class AddTagsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :tags, :hstore
  end
end
