class StationsController < ApplicationController
	before_action :set_station, only: [:show]
	def index 
		@stations = Station.all
	end
	def show
		@recommendations = Station.last(5)
	end

	

	private 
		def set_station
			@station = Station.find_by(slug: params[:id])
		end
end
