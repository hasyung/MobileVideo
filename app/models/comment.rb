class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type,:body
  
  # Associations
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  
  # Validates
  validates :commentable_id, :commentable_type, :body, :presence => true
  with_options :if => :body? do |body|
    body.validates :body, :length => { :within => 2..1000 }
  end
  
  # Scopes
  scope :created_desc, order("created_at DESC")
end
