class Api::V1::PodcastsController < Api::BaseController
	def index
		@podcasts = Podcast.all.order(created_at: "DESC")
    	paginate json: @podcasts, adapter: :json, per_page: 20
	end
	def add_one_second_played
		p_id = params[:id]
		if Podcast.exists?(id: p_id)
			result = Podcast.find(p_id)
			if result.seconds_played
				result.update_attributes(seconds_played: result.seconds_played + 1)
			else
				result.update_attributes(seconds_played: 1)
			end
			json_response(true)
		else
			json_response(false)
		end
	end
end
