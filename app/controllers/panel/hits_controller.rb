class Panel::HitsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_hits_permission
	# load_and_authorize_resource
	def index
		@hits = Hit.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).paginate(page: params[:page], per_page: 20)
		@hit_objectives = HitObjective.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)	
	end
	def graph
		if params.count >= 3
			initial_date = Date.new params[:hit]["initial_date(1i)"].to_i, params[:hit]["initial_date(2i)"].to_i, params[:hit]["initial_date(3i)"].to_i
			end_date	 = Date.new params[:hit]["end_date(1i)"].to_i, params[:hit]["end_date(2i)"].to_i, params[:hit]["end_date(3i)"].to_i
			section_id	= params[:hit][:section_id]
			@hits = Hit.search(initial_date, end_date, params[:hit][:section_id])

			@hit_objectives = HitObjective.where("created_at >= '#{initial_date.beginning_of_day}' AND created_at <= '#{end_date.end_of_day}' AND section_id = '#{section_id}'").group_by { |l| [l.created_at.beginning_of_week, l.created_at.month, l.created_at.year] }
			# @hits = Hit.joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = #{params[:section_id]} AND hits.created_at >= '#{params[:initial_date]}' AND hits.created_at <= '#{params[:end_date]}'")	
    	else
    		@hits = []
    		@hit_objectives = []
    	end
    	p @hits		
	end
	def author_graph
		if params.count >= 3
			initial_date = Date.new params[:hit]["initial_date(1i)"].to_i, params[:hit]["initial_date(2i)"].to_i, params[:hit]["initial_date(3i)"].to_i
			end_date	 = Date.new params[:hit]["end_date(1i)"].to_i, params[:hit]["end_date(2i)"].to_i, params[:hit]["end_date(3i)"].to_i
			section_id	= params[:hit][:author_id]
			@hits = Hit.search_by_author(initial_date, end_date, params[:hit][:author_id])
    	else
    		@hits = []
    		@hit_objectives = []
    	end	
    	p @hits	
	end
	

end
