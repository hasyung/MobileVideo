class Video < ActiveRecord::Base
  attr_accessible :name, :video, :description, :duration, :cover, :status_cd, :comments_attributes

  # Associations
  has_many :comments, :as => :commentable, :dependent => :destroy, :order => "created_at DESC"
  
  # NestedAttributes
  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:body].blank? }, :allow_destroy => true
    
  # Callbacks
  before_save :update_video_attributes, :update_cover_attributes

  # SimpleEnum
  as_enum :status, { unaudited: 0, rejected: 1, passed: 2 }
  
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
  scope :status_asc, order("status_cd ASC")
  scope :search_name, lambda { |name| where("ucase(`videos`.`name`) like concat('%',ucase(?),'%')", name) }

  # PrivateMethods
  private
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
