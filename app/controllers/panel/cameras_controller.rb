class Panel::CamerasController < ApplicationController
	before_action :authenticate_user!
	before_action :set_camera, only: [:show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]
	def index 
		@cameras = Camera.all
	end
	def new
		@camera = Camera.new
	end
	def create
		@camera = Camera.new(camera_params)
		if @camera.save 
			redirect_to panel_cameras_path
		else
			render action: "new"
		end
	end
	def edit 
	end
	def update
		if @camera.update(camera_params)
			redirect_to panel_cameras_path
		else
			render action: "edit"
		end
	end
	def destroy
		@camera.destroy
		redirect_to panel_cameras_path 
	end

	private
		def set_camera 
			@camera = Camera.find(params[:id])
		end
		def camera_params
			params.require(:camera).permit(:name, :location, :lat, :lng, :stream, :cover)
		end
		def set_s3_direct_post
			one_year_in_seconds = 365 * 24 * 60 * 60
			one_year_from_now = Time.now + one_year_in_seconds
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', expires: one_year_from_now, cache_control: "max-age=#{one_year_in_seconds}")
  		end
end
