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
	def get_banners 
	    time = DateTime.now.to_date
	    if params[:type] and params[:id] 
			@banners = Banner.joins("INNER JOIN section_banners ON section_banners.banner_id = banners.id AND section_banners.sectionable_type = #{params[:type]} AND expiry_date > '#{time}' AND section_banners.sectionable_id = #{params[:id]}")
		end
		if @banners 
			json_response(@banners, :ok)
		else
			render json: { error: "Not found" }, status: :not_found
		end
	end
end
