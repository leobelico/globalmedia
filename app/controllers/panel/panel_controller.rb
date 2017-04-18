class Panel::PanelController < ApplicationController

	before_action :authenticate_user!

	def show_global_recommendations
		@articles = Article.all
	end


	def set_global_recommendations
		articles =  Article.where(id: params[:all_recommendations])
		articles_in_highlights = Article.where(global_recommendation: true)
		articles.each do |article|
			article.update_attributes(global_recommendation: true)
		end 

		if articles.count >= 4
			articles.each do |this_article|
				created = false
				articles_in_highlights.each do |a_in_h|
					if this_article == a_in_h
						created = true
					end
				end
				if created == false
					article.update_attributes(global_recommendation: true, updated_recommendation_on: DateTime.now)
				end
			end

			if articles_in_highlights.count >= 4
				get_first_h = Article.where(global_recommendation: true).order(updated_at: "ASC").first(articles_in_highlights.count - 3)
				get_first_h.each do |h|
					h.update_attributes(global_recommendation: false)
				end 
			end
		end


		if articles_in_highlights.count == 0
			articles.each do |article|
				article.update_attributes(global_recommendation: true, updated_recommendation_on: DateTime.now)
			end
		end

		#Article.all.each do |article|
		#		article.update_attributes(global_recommendation: false)
		#	end
		redirect_back(fallback_location: root_url)
		
	end

	def panel
	end 

end
