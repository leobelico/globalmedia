class StationsController < ApplicationController
	before_action :set_station, only: [:show, :articles]
	before_action :set_station_on_id, only: [:articles]
	def index 
		@radio_programs = Station.where(video: false, news: false).order(frequency: "ASC")
		@video_programs = Station.where(video: true).order(frequency: "ASC")
		@news_channels = Station.where(news: true).order(frequency: "ASC")
	end
	def show
		@recommendations = Station.where("id != '#{@station.id}'").last(7)
	    time = Time.now
	    if time.sunday? 
	      @timetables = Timetable.where("(sunday = 'true' AND (streaming_hour < '#{time}' AND end_streaming_hour > '#{time}') OR streaming_hour > '#{time}') AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.monday? 
	      @timetables = Timetable.where("(monday = 'true' AND (streaming_hour < '#{time}' AND end_streaming_hour > '#{time}') OR streaming_hour > '#{time}') AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.tuesday? 
	      @timetables = Timetable.where("(tuesday = 'true' AND (streaming_hour < '#{time}' AND end_streaming_hour > '#{time}') OR streaming_hour > '#{time}') AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.wednesday? 
	      @timetables = Timetable.where("(wednesday = 'true' AND (streaming_hour < '#{time}' AND end_streaming_hour > '#{time}') OR streaming_hour > '#{time}') AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.thursday? 
	      @timetables = Timetable.where("(thursday = 'true' AND (streaming_hour < '#{time}' AND end_streaming_hour > '#{time}') OR streaming_hour > '#{time}') AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.friday? 
	      @timetables = Timetable.where("(friday = 'true' AND (streaming_hour < '#{time}' AND end_streaming_hour > '#{time}') OR streaming_hour > '#{time}') AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    if time.saturday? 
	      @timetables = Timetable.where("(saturday = 'true' AND (streaming_hour < '#{time}' AND end_streaming_hour > '#{time}') OR streaming_hour > '#{time}') AND station_id = '#{@station.id}'").first(5)
	    end
	   
	    p @timetables

	end

	def articles 
		@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Station' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Station'").order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
		# @articles = []
		# @station.article_relationships.each do |relationship| 
		# 	@articles << relationship.article
		# end
		# @articles.paginate(page: params[:page], per_page: 10)
 	end

	private 
		def set_station_on_id 
			@station = Station.find_by(slug: params[:station_id])
		end
		def set_station
			@station = Station.find_by(slug: params[:id])
		end
end
