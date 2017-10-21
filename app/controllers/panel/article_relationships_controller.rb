class Panel::ArticleRelationshipsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_news_chief
	
	

	def destroy
		@article_relationship = ArticleRelationship.find(params[:id])
		@article_relationship.destroy
		redirect_back(fallback_location: panel_path)
	end

	

  		
end
