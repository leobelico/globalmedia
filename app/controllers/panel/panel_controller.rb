class Panel::PanelController < ApplicationController

	before_action :authenticate_user!

	def show_global_recommendations
		@articles = Article.all
	end


	def set_global_recommendations
		
    	GlobalRecommendationArticle.where(global_recommendation: true).delete_all
		
		if params[:panel][:first_article_id] != ""
			first_article = Article.find(params[:panel][:first_article_id])
			GlobalRecommendationArticle.create(name: first_article.name, article_slug: first_article.slug, article_image: first_article.image, global_recommendation: true, article_id: first_article.id)
		end
		if params[:panel][:second_article_id]  != ""
			second_article = Article.find(params[:panel][:second_article_id])
			GlobalRecommendationArticle.create(name: second_article.name, article_slug: second_article.slug, article_image: second_article.image, global_recommendation: true, article_id: second_article.id)

		end
		if params[:panel][:third_article_id]  != ""
			third_article = Article.find(params[:panel][:third_article_id])
			GlobalRecommendationArticle.create(name: third_article.name, article_slug: third_article.slug, article_image: third_article.image, global_recommendation: true, article_id: third_article.id)

			
		end

		#Article.all.each do |article|
		#		article.update_attributes(global_recommendation: false)
		#	end
		redirect_back(fallback_location: root_url)
		
	end

	def panel
	end 

end
