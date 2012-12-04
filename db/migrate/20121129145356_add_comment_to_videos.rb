class AddCommentToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :comment, :string
  end
  def down
    remove_column :videos, :comment
  end
end
