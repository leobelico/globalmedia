class BannersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_banner, only: [:show, :edit, :update, :destroy]
	def index
		@banners = Banner.all
	end

	def new
		@banner = Banner.new	
	end

	def create
		@banner = Banner.new(banner_params)
		if @banner.save
			redirect_to @banner
		else
			render action: "new"
		end
	end

	def edit

	end

	def update
		if @banner.update(banner_params)
			redirect_to @banner
		else
			render action: "edit"
		end
	end

	def destroy
		@banner.destroy
		redirect_to @banner
	end

	private
		def banner_params
			params.require(:banner).permit(:large_image, :small_image, :size, :name )
		end

		def set_banner
			@banner = Banner.find(params[:id])
		end

end
