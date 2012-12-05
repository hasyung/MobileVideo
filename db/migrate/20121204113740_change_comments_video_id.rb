class ChangeCommentsVideoId < ActiveRecord::Migration
  def up
    add_column :comments, :commentable_id, :integer, :null => false
    add_column :comments, :commentable_type, :string, :null => false
    remove_column :comments, :video_id
  end

  def down
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type
    add_column :comments, :video_id, :integer, :null => false
  end
end
