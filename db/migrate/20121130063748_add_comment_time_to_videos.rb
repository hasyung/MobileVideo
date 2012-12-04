class AddCommentTimeToVideos < ActiveRecord::Migration
   def up
    add_column :videos, :comment_time, :datetime
    add_column :videos, :status_cd, :integer, :default => 0
  end
  def down
    remove_column :videos, :comment_time
    remove_column :videos, :status_cd
  end
end
