class Video < ActiveRecord::Base
  attr_accessible :name, :video, :description, :duration, :cover, :status_cd

   # Associations
  has_many :comments, :order => "created_at DESC"
  
   # Callbacks
  before_save :update_video_attributes, :update_cover_attributes

   #SimpleEnum
  as_enum :status, { :draft => 0, :publish => 1 }
  
  # Carrierwave
  mount_uploader :video, VideoUploader
  mount_uploader :cover, CoverUploader

  # Validates
  validates :name, :video, :cover, :duration, :presence => true
  with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..100 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 2..1000 }
  end
  with_options :if => :duration do |duration|
    duration.validates :duration, :format => { :with => /(?:[01]\d|2[0-3])(?::[0-5]\d){2}$/, 
      :message => I18n.translate("errors.messages.format_invalid") }
  end
  
  # Scopes
  scope :created_desc, order("created_at DESC")
  scope :search_name, lambda { |name| where("ucase(`videos`.`name`) like concat('%',ucase(?),'%')", name) }

  def update_video_attributes
    if video.present? && video_changed?
      self.video_size = video.file.size
      self.video_content_type = video.file.content_type
    end
  end
  def update_cover_attributes
    if cover.present? && cover_changed?
      self.cover_size = cover.file.size
      self.cover_content_type = cover.file.content_type
    end
  end
end
