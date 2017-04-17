class ArticlesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	
	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user
		p "------------------------"
		p params[:article][:note]
		@article.note = params[:article][:note]
		if @article.save
			redirect_to @article
		else
			render action: "new"
		end
	end

	def show

		# @article.note
		@note = @article.note["quill"].to_s
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

	def edit
	end

	def update
		@article.note = params[:article][:note]
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
			# params.require(:article).permit(:name, :plain_text, :short_description, :hashtags_names, :articable_id, :articable_type, :keyword_id)
			params.require(:article).permit_all_parameters = true
		end

		def set_article
			@article = Article.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
