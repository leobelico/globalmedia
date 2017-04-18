class ArticlesController < ApplicationController
	before_action :set_article, only: [:show]
	
	def index
		@articles = Article.all
	end
	def show

		# @article.note
		@note = @article.note
		if !user_signed_in?
			last_hit = Hit.where(article: @article, created_at: 1.hours.ago..Time.now).last

			if last_hit
				last_hit.update_attributes(number: last_hit.number + 1)
			else
				#no hay ningún hit entonces lo creamos
				Hit.create(number: 1, article: @article)

			end
		end
	end

	
	def search_hashtag
		@search = Hashtag.find(params[:search])
		@hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
		

	end

	private
		def article_params
			params.require(:article).permit(:name, :note, :plain_text, :short_description, :hashtags_names, :articable_id, :articable_type, :keyword_id)
		end

		def set_article
			@article = Article.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
