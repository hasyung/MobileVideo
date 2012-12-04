class AddColumnsToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :cover, :string, :null => false
    add_column :videos, :cover_size, :integer, :default => 0
    add_column :videos, :cover_content_type, :string
    add_column :videos, :duration, :string
    change_column :videos, :video_size, :integer, :default => 0
  end
  def down
    remove_column :videos, :cover
    remove_column :videos, :cover_size
    remove_column :videos, :cover_content_type
    remove_column :videos, :duration
    change_column :videos, :video_size, :integer, :default => 0
  end
end
