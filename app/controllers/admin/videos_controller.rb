class Admin::VideosController < Admin::ApplicationController
	def index
		@videos = Video.page(params[:page]).per(10).created_desc
	end

	def show
		@video = Video.find params[:id]
	end

	def new
		@video = Video.new
	end

	def create
		@video = Video.new params[:video]
		if @video.save
			redirect_to admin_video_path(@video), :notice => t("helpers.messages.new", :model_name => Video.model_name.human)
		else
			render :new
		end
	end

	def edit
		@video = Video.find params[:id]
	end

	def update
		@video = Video.find params[:id]
    if @video.update_attributes params[:video]
     	redirect_to admin_video_path(@video), :notice => t("helpers.messages.edit", 
     		:model_name => Video.model_name.human)
    else
     	render :action => "edit"
    end
	end

	def destroy
		@video = Video.find params[:id]
    if @video.destroy
     	redirect_to :admin_videos, :notice => t("helpers.messages.destroy", 
     		:model_name => Video.model_name.human)
    else
     	redirect_to :admin_videos, :alert => t("helpers.messages.error")
    end
	end

	def destroies
		if params[:video_ids].blank?
			return redirect_to :admin_videos,
					:alert => t("helpers.messages.selected_error",
							:model_name => Video.model_name.human)
		end
		if Video.destroy(params[:video_ids])
			redirect_to :admin_videos, 
					:notice => t("helpers.messages.destroy_multiple", 
							:count => params[:video_ids].size,
									:model_name => Video.model_name.human)
		else
			redirect_to :admin_videos, :alert => t("helpers.messages.notices.error")
		end
	end

	def search
		if params[:video][:name].blank?
			redirect_to :admin_videos, :alert => t("helpers.messages.search_error")
			return
		else
			@videos = Video.search_name(params[:video][:name]).page(params[:page]).per(10)
		end
		render :action => "index"
	end
end
