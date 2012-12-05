class VideosController < ApplicationController
	def index
		@videos = Video.page(params[:page]).per(5).created_desc
	end

	def show
    @video = Video.find params[:id]
    @comment = @video.comments.new
	end
  
  def update
		@video = Video.find params[:id]
    count = @video.comments.count
    if @video.update_attributes params[:video]
      if count < @video.comments.count
     	 redirect_to video_path(@video), :notice => t("helpers.messages.new", :model_name => Comment.model_name.human)
      else
        redirect_to video_path(@video)
      end
    else
     	render :show
    end
	end

	def search
		if params[:video][:name].blank?
			redirect_to :videos, :alert => t("helpers.messages.search_error")
			return
		else
			@videos = Video.search_name(params[:video][:name]).page(params[:page]).per(5)
		end
		render :action => "index"
	end
  
  def publish
    @video = Video.find params[:id]
		@video.status = params[:status].to_s.to_sym
		if @video.save
			if @video.publish?
				redirect_to :video, :notice => t("helpers.messages.access")
			else
				redirect_to :video, :notice => t("helpers.messages.access")
			end
		else
			redirect_to :video, :alert => t("helpers.messages.error")
		end
	end
end
