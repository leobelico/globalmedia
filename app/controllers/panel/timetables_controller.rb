class Panel::TimetablesController < ApplicationController
	before_action :authenticate_user!

	
	def destroy
		@timetable = Timetable.find(params[:id])

		@timetable.destroy
		redirect_to :back
	end

	
end
