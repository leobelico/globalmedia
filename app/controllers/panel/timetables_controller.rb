class Panel::TimetablesController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource, through: :station
		def destroy
		@timetable = Timetable.find(params[:id])

		@timetable.destroy
		redirect_to :back
	end

	
end
