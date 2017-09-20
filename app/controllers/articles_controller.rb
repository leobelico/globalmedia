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
		# if !user_signed_in? and @article.published == true

			
		# 	session[:current_position] = "Articles"
		# 	last_hit = Hit.where(article: @article, created_at: 2.hours.ago..Time.now).last

		# 	if last_hit
		# 		last_hit.update_attributes(number: last_hit.number + 1)
		# 	else
		# 		#no hay ningún hit entonces lo creamos
		# 		Hit.create(number: 1, article: @article)

		# 	end
		# end
		@related_sections = RelatedSection.where(section: Section.find_by(name: @article.section))
		p "-------------------------------"
		p @article.section
		p @related_sections
		@collaborator_articles = nil 
	end

	
	def search_hashtag
		@search = Hashtag.find(params[:search])
		# @hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
		@articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND articles_hashtags.hashtag_id = #{ params[:search] } AND articles.published = true").paginate(page: params[:page], per_page: 20)
	end

	private
		def article_params
			params.require(:article).permit(:name, :note, :plain_text, :short_description, :hashtags_names, :articable_id, :articable_type, :keyword_id)
		end

		
end
