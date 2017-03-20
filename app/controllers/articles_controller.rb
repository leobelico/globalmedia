class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to @article
		else
			render action: "new"
		end
	end

	def show
	end

	def edit
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render action: "edit"
		end
	end

	def destroy
		@article.destroy
		redirect_to @articles
	end

	def search_hashtag
		@search = Hashtag.find(params[:search])
		@hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
		

	end

	private
		def article_params
			params.require(:article).permit(:name, :note, :short_description, :hashtags_names)
		end

		def set_article
			@article = Article.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
