class Api::V1::ArticlesController < Api::BaseController
	before_action :set_article, only: [:show]
	def index
		@articles = Article.where(published: true).order(created_at: "DESC") 
    	paginate json: @articles, adapter: :json, per_page: 20
	end
	def highlights 
		# @highlights = Highlight.where(published: true).order(order: "ASC")
		@articles = Article.joins("INNER JOIN highlights ON highlights.article_id = articles.id WHERE highlights.published = true")
		if @articles 
			json_response(@articles, :ok)
		else
			render json: { error: "Not found" }, status: :not_found
		end
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

	def latest_collaborator_articles
		
		#relationship = @relationship.article_relationships
		@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Collaborator'").order(created_at: "DESC") 

		@articles.each do |article|
			collaborator_name = article.article_relationships.where(articable_type: "Relationship").first.articable.name 
			collaborator_image = article.article_relationships.where(articable_type: "Relationship").first.articable.image 
			@article_images << [collaborator_name, collaborator_image]
		end
		#@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship'")

		#Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship'").order(created_at: "DESC") 
		# 
		#@articles = @articles.where()
		#<% @relationship.article_relationships.each do |relationship| %>
		
		render json: { articles: @articles, article_images: @article_images.to_json }, adapter: :json, per_page: 20 

	end
	def latest_special_investigation 
		@investigation = Relationship.where(relationship_type: "Investigation").last
		if @investigation 
			json_response(@investigation, :ok)
		else
			render json: { error: "Not found" }, status: :not_found
		end

	end	
	def latest_special_investigation_articles

		@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Investigation'").order(created_at: "DESC") 
		
		render json: @articles, adapter: :json, per_page: 20 

	end

	def latest_complaints_articles
		
		@articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Complaint'").order(created_at: "DESC") 
		
		render json: @articles, adapter: :json, per_page: 20 
	end

	def search
      @articles = Article.where('LOWER(name) LIKE ? AND published = ?', "%#{params[:name]}%", true).order(created_at: "DESC").last(30)
      json_response(@articles)
    end

    def search_with_dates_and_category
    	section = Section.find_by_name(params[:category_name])
      @articles = Article.where('articable_id = ? AND articable_type = ? AND created_at BETWEEN ? AND ?', section.id, 'Section', params[:initial_date], params[:final_date]).order(created_at: "DESC").last(30)
      json_response(@articles)
    end

    def related_by_hashtags
    	article = Article.find(params[:article_id])
	    if article.hashtags.count == 1
	       @articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND articles_hashtags.hashtag_id = #{ article.hashtags.first.id} AND articles.published = true AND articles.id != #{params[:article_id]}").last(3).uniq

	    end

	    if article.hashtags.count == 2
	      @articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND (articles_hashtags.hashtag_id = #{ article.hashtags.first.id } OR articles_hashtags.hashtag_id = #{ article.hashtags.second.id }) AND articles.published = true AND articles.id != #{params[:article_id]}").last(3).uniq
	    end 
	    
	    if article.hashtags.count >= 3
	      @articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND (articles_hashtags.hashtag_id = #{ article.hashtags.first.id } OR articles_hashtags.hashtag_id = #{ article.hashtags.second.id } OR articles_hashtags.hashtag_id = #{ article.hashtags.third.id }) AND articles.published = true AND articles.id != #{params[:article_id]}").last(3).uniq
	    end 
	    # @hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
	   
	    render json: @articles, adapter: :json, per_page: 20

	end

	def get_global_recommendations
	    @articles = Article.where(global_recommendation: true, published: true).order(updated_at: "ASC").last(4)
	    render json: @articles, adapter: :json
  	end

	def search_hashtag
		search = Hashtag.find(params[:id])
		# @hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
		@articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND articles_hashtags.hashtag_id = #{ search.id} AND articles.published = true").paginate(page: params[:page], per_page: 20)
		render json: @articles, adapter: :json, per_page: 20
	end

	private 
		def set_article
			@article = Article.where(published: true).find(params[:id])

		end
end
