class Panel::PanelController < ApplicationController

	before_action :authenticate_user!

	def show_global_recommendations
		@articles = Article.all
	end


	def set_global_recommendations
		Rails.cache.flush
		

		articles_in_highlights = Article.where(global_recommendation: true)
		articles_in_highlights.update_all(global_recommendation: false)
		if params[:panel][:first_article_id] != ""
			first_article = Article.find(params[:panel][:first_article_id])
			first_article.update_attributes(global_recommendation: true)
		end
		if params[:panel][:second_article_id]  != ""
			second_article = Article.find(params[:panel][:second_article_id])
			second_article.update_attributes(global_recommendation: true)
		end
		if params[:panel][:third_article_id]  != ""
			third_article = Article.find(params[:panel][:third_article_id])
			third_article.update_attributes(global_recommendation: true)
			
		end

		#Article.all.each do |article|
		#		article.update_attributes(global_recommendation: false)
		#	end
		redirect_back(fallback_location: root_url)
		
	end

	def panel
	end 

end
