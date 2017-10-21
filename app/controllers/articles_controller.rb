require 'uri'
class ArticlesController < ApplicationController
	before_action :set_article, only: [:show]
	
	def index
		@articles = Article.all
	end
	def show

		# @article.note
		@note = @article.note
	 
		if !user_signed_in? and @article.published == false 
			redirect_to root_url
		end
		if !user_signed_in? and @article.published == true

			SaveHitsJob.perform_later @article
		
		end
		if @article.articable_id
			@related_sections = RelatedSection.where(section_id: @article.articable_id)
		end
		@collaborator_articles = nil 
		
	end

	
	def search_hashtag
		@search = Hashtag.find(params[:search])
		# @hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
		@articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND articles_hashtags.hashtag_id = #{ params[:search] } AND articles.published = true").order(created_at: "DESC").paginate(page: params[:page], per_page: 8)
	end

	private
		def article_params
			params.require(:article).permit(:name, :note, :plain_text, :short_description, :hashtags_names, :articable_id, :articable_type, :keyword_id)
		end

		
end
