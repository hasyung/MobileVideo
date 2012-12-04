class CommentsController < ApplicationController
  def new
		@comment = Comment.new
	end

	def create
		@video = Video.find params[:video_id]
		@comment = @video.comments.new params[:comment]
		if @comment.save
			redirect_to video_path(@comment.video), :notice => t("helpers.messages.new", :model_name => Comment.model_name.human)
		else
			redirect_to video_path(@comment.video)
		end
	end
end