class Api::V1::BannersController < Api::BaseController
	def index
	    time = DateTime.now.to_date
        @banners = Banner.where("active = 'true' AND expiry_date > '#{time}'").reverse
		if @banners 
			json_response(@banners, :ok)
		else
			render json: { error: "Not found" }, status: :not_found
		end
	end
end
