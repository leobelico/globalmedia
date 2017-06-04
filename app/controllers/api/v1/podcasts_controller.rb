class Api::V1::PodcastsController < ApplicationController
	def index
		@podcasts = Podcast.all.order(created_at: "DESC") 
    	paginate json: @podcasts, adapter: :json, per_page: 20
	end
end
