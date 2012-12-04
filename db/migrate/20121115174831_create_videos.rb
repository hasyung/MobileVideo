class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
    		t.string		:name,	:null => false
    		t.string		:video,	:null => false
    		t.string		:video_size,		:default => 0
    		t.string		:video_content_type
    		t.string		:description
      t.timestamps
    end

    def down
    	drop_tabel :videos
    end
  end
end
