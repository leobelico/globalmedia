class Panel::HitsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_hits_permission
	# load_and_authorize_resource
	def index
		@hits = Hit.all
		@hit_objectives = HitObjective.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)	
	end
	def graph
		if params.count == 3
			params[:initial_date] = params[:initial_date].to_s
			params[:end_date] = params[:end_date].to_s
			@hits = Hit.search(params)
	    	# @hits = Hit.joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = #{params[:section_id]} AND hits.created_at >= '#{params[:initial_date]}' AND hits.created_at <= '#{params[:end_date]}'")	
    	else
    		@hits = Hit.all
    	end		
	    p @hits

	end
	

end
