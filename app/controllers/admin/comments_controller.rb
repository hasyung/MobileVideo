class Admin::CommentsController < Admin::ApplicationController
  
  def index
		@comments = Comment.page(params[:page]).per(10).created_desc
    @model
	end
  
end