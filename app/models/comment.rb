class Comment < ActiveRecord::Base
  attr_accessible :body
  
  # Associations
  belongs_to :video, :counter_cache => true
  
  # Validates
  validates :body, :presence => true
  with_options :if => :body? do |body|
    body.validates :body, :length => { :within => 2..1000 }
  end
  
  # Scopes
  scope :created_desc, order("created_at DESC")
end
