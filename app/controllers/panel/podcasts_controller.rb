class Panel::PodcastsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_radio_stations_permission
	before_action :set_station
	before_action :set_podcast, only: [:show, :edit, :update, :destroy]

	

	def new
		@podcast = @station.podcasts.build
	end

	def create
		@podcast = @station.podcasts.build(podcast_params)
		if @podcast.save
			redirect_to panel_station_path(@station)
		else
			render action: "new"
		end
	end

	def edit
	end

	def update
		if @podcast.update(podcast_params)
			redirect_to panel_station_path(@station)
		else
			render action: "new"
		end
	end
	def show
	end

	def destroy
		@podcast.destroy
		redirect_to panel_station_path(@station)
	end

	
	private
		def podcast_params
			params.require(:podcast).permit(:name, :stream_url)
		end

		def set_station
			@station = Station.find_by_slug(params[:station_slug])
			
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_ur

		end

		def set_podcast
			@podcast = @station.podcasts.find(params[:id])

		end
	
end
