class Api::V1::CamerasController < Api::BaseController
	def index 
		@cameras = Camera.all 
		json_response @cameras, :ok
	end

	def show
		@camera = Camera.find(params[:id])
		json_response(@camera, :ok)
	end
end
