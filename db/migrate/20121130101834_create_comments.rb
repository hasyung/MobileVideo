class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references  :video, :null => false
      t.string :body, :null => false
      t.timestamps
    end
    add_column  :videos, :comments_count, :integer, :default => 0
    remove_column :videos, :comment
  end
  
  def down
    drop_table :comments
    add_column :videos, :comment, :string
    remove_column :videos, :comments_count
  end
end
