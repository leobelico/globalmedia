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
	def search
		search = Hashtag.find_by(name: params[:hashtag])
		@articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND articles_hashtags.hashtag_id = #{ params[:search] } AND articles.published = true")
		render json: @articles, adapter: :json, per_page: 20 
	end

	def latest_collaborator_articles
		
		#relationship = @relationship.article_relationships
		@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Collaborator'").order(created_at: "DESC") 
		#@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship'")

		#Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship'").order(created_at: "DESC") 
		# 
		#@articles = @articles.where()
		#<% @relationship.article_relationships.each do |relationship| %>
		
		render json: @articles, adapter: :json, per_page: 20 

	end

	def latest_special_investigation_articles

		@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Investigation'").order(created_at: "DESC") 
		
		render json: @articles, adapter: :json, per_page: 20 

	end

	def latest_complaints_articles
		
		@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Complaint'").order(created_at: "DESC") 
		
		render json: @articles, adapter: :json, per_page: 20 
	end

	private 
		def set_article
			@article = Article.where(published: true).find(params[:id])

		end
end
