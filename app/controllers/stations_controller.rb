class StationsController < ApplicationController
	before_action :set_station, only: [:show]
	def index 
		@radio_programs = Station.where(video: false)
		@video_programs = Station.where(video: true)
		@news_channels = Station.where(news: true)
	end
	def show
		@recommendations = Station.last(5)
	    time = Time.now
	    if time.sunday? 
	      @timetables = Timetable.where("sunday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}' AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.monday? 
	      @timetables = Timetable.where("monday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}' AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.tuesday? 
	      @timetables = Timetable.where("tuesday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}' AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.wednesday? 
	      @timetables = Timetable.where("wednesday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}' AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.thursday? 
	      @timetables = Timetable.where("thursday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}' AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.friday? 
	      @timetables = Timetable.where("friday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}' AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.saturday? 
	      @timetables = Timetable.where("saturday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}' AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    p @timetables

	end

	

	private 
		def set_station
			@station = Station.find_by(slug: params[:id])
		end
end
