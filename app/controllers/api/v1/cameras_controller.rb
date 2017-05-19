class Api::V1::CamerasController < Api::BaseController
	def index 
		@cameras = Camera.all 
		json_response @cameras, :ok
	end
end
