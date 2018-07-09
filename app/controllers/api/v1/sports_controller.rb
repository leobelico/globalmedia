class Api::V1::SportsController < Api::BaseController
	def index
		@sports = Sport.all.order(created_at: "DESC") 
		p "SPORTSSS"
		p @sports
    	paginate json: @sports, adapter: :json, per_page: 20
	end
	

end
