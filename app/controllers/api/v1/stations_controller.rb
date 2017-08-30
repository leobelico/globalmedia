class Api::V1::StationsController < Api::BaseController
	# before_action :set_station, only: [:index]
	def index
		@stations = Station.all 		
		json_response @stations, :ok
	end

	def show
		@station = Station.find(params[:id])
		json_response(@station, :ok)
	end
	# private
	# 	def set_station 
	# 		@station = Station.find(params[:id])
	# 	end
end
