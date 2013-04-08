class RemoveTagsColumn < ActiveRecord::Migration
  def self.up
    remove_column :meetings, :tags
  end

  def self.down
    add_column :meetings, :tags, :text
  end
end
