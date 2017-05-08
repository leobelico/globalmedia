class CamerasController < ApplicationController
	before_action :set_camera, only: [:show]

	def index
		@cameras = Camera.all
	end
	def show 
	end

	private

		def set_camera
			@camera = Camera.find(params[:id])
		end
end
