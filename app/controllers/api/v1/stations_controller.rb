class Api::V1::StationsController < Api::BaseController
	# before_action :set_station, only: [:index]
	def index
		@stations = Station.all 		
		json_response @stations, :ok
	end
	# private
	# 	def set_station 
	# 		@station = Station.find(params[:id])
	# 	end
end
