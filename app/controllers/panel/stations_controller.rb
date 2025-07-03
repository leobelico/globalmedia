class Panel::StationsController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_radio_stations_permission
	before_action :set_station, only: [:show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]

	def index
		@stations = Station.all.order(name: "ASC")
	end

	def new
		@station = Station.new
		1.times { @station.timetables.build }
		
	end

	def show
	end
	def create
		@station = Station.new(station_params)
		if @station.save
			@station.update(slug: @station.slug) 

			redirect_to panel_station_path(@station)
		else
			render action: "new"
		end
	end

	def edit
	end

	def update
		if @station.update(station_params)
			redirect_to panel_station_path(@station)
		else
			render action: "edit"
		end
	end

	def destroy
		@station.destroy
		redirect_to panel_stations_path
	end

	def add_article_to_stations
		@station = Station.find_by_slug(params[:format])

	end

	def set_station_articles
		station = Station.find(params[:panel][:station_id])
		
		first_article = Article.find(params[:panel][:first_article_id])
		if station.id
			r = ArticleRelationship.create(article: first_article, articable_id: station.id, articable_type: "Station" )
		else
			flash[:error] = "No se pudo guardar, intenta de nuevo."
		end
		redirect_to panel_station_path(station)
	end

	private
		def station_params
			params.require(:station).permit(:name, :image_preview, :frequency, :description, :stream_url, :app_url, :news, :playlist_1, :playlist_2, :playlist_3, :playlist_4, :playlist_1_image, :playlist_2_image, :playlist_3_image, :playlist_4_image, :video, :facebook, :twitter, :image, timetables_attributes: [:id, :streaming_hour, :description, :image, :broadcaster_image, :name, :broadcasters, :end_streaming_hour,  :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :_destroy])
		end

		def set_station
			@station = Station.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_ur

		end
		def set_s3_direct_post
			one_year_in_seconds = 365 * 24 * 60 * 60
			one_year_from_now = Time.now + one_year_in_seconds
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', expires: one_year_from_now, cache_control: "max-age=#{one_year_in_seconds}")
  		end
end
