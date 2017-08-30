class Api::V1::DevicesController < Api::BaseController
	def create 
		
		@device = Device.create!(token: params[:token], operating_system: params[:operating_system])
		json_response(@device, :created)
	end
	private 
		def device_params 
			params.require(:device).permit(:token, :operating_system)
		end
end
