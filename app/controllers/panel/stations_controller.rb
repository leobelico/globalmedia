class Panel::StationsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_station, only: [:show, :edit, :update, :destroy]

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
			render action: "new"
		end
	end

	def destroy
		@station.destroy
		redirect_to panel_stations_path
	end

	private
		def station_params
			params.require(:station).permit(:name, :stream_url, :image, timetables_attributes: [:id, :streaming_hour, :name, :end_streaming_hour,  :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :_destroy])
		end

		def set_station
			@station = Station.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_ur

		end
end
