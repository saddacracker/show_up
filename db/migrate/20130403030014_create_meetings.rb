class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :time
      t.integer :duration
      t.text :days_of_week
      t.boolean :closed_meeting
      t.string :title
      t.text :description
      t.text :tags

      t.timestamps
    end
  end
end
