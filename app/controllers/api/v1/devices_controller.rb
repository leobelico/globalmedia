class Api::V1::DevicesController < Api::BaseController
	def create 
		@device = Device.create!(device_params)
		json_response(@device, :created)
	end
	private 
		def device_params 
			params.require(:device).permit(:token, :operating_system)
		end
end
