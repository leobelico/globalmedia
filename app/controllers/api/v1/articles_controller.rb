class Api::V1::ArticlesController < Api::BaseController
	before_action :set_article, only: [:show]
	def index
		@articles = Article.where(published: true).order(created_at: "DESC") 
    	paginate json: @articles, adapter: :json, per_page: 20
	end

	def show 
		if @article 
			json_response(@article, :ok)
		else
			render json: { error: "Not found" }, status: :not_found
		end
	end
	def most_visited 
	    @articles = Article.joins("LEFT OUTER JOIN hits ON hits.article_id = articles.id").where("articles.published = true AND articles.highlight = false AND articles.global_recommendation = false AND hits.created_at > ? AND hits.created_at < ?", 2.hours.ago, Time.now).last(6)
	    json_response(@articles, :ok)
	end
	private 
		def set_article
			@article = Article.where(published: true).find(params[:article_id])

		end
end
