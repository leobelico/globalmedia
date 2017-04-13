class PanelController < ApplicationController


	def show_global_recommendations
		@articles = Article.all
	end


	def set_global_recommendations
		articles =  Article.where(id: params[:all_recommendations])
		articles.each do |article|
			article.update_attributes(global_recommendation: true)
		end 

		redirect_back(fallback_location: root_url)
		
	end

	def panel
	end 

end
