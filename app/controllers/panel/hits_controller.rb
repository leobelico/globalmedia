class Panel::HitsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_hits_permission
	# load_and_authorize_resource
	def index
		@hits = Hit.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
		@hit_objectives = HitObjective.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)	
	end
	def graph
		if params.count >= 3
			initial_date = Date.new params[:hit]["initial_date(1i)"].to_i, params[:hit]["initial_date(2i)"].to_i, params[:hit]["initial_date(3i)"].to_i
			end_date	 = Date.new params[:hit]["end_date(1i)"].to_i, params[:hit]["end_date(2i)"].to_i, params[:hit]["end_date(3i)"].to_i
			@hits = Hit.search(initial_date, end_date, params[:hit][:section_id])
			# @hits = Hit.joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = #{params[:section_id]} AND hits.created_at >= '#{params[:initial_date]}' AND hits.created_at <= '#{params[:end_date]}'")	
    	else
    		@hits = []
    	end		
	    p @hits

	end
	

end
