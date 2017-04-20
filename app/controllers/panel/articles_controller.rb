class Panel::ArticlesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	autocomplete :article, :name, full: true
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]
	
	def index
		@articles = Article.all.order(created_at: "DESC")
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user

		if @article.save
			@article.update_attributes(slug: @article.slug + "-" + @article.id.to_s) 
			redirect_to @article
		else
			render action: "new"
		end
	end

	def show

	end

	def edit
		if @article.hashtags.count > 0	
			@hashtags = ""
			@article.hashtags.each do |hashtag|
				@hashtags = @hashtags + " " + hashtag.name
			end
		end
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
		redirect_to panel_articles_path
	end

	def search_hashtag
		@search = Hashtag.find(params[:search])
		@hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
		

	end

	private
		def article_params
			# params.require(:article).permit(:name, :note, :plain_text, :image, :image_thumbnail, :short_description, :hashtags_names, :articable_id, :articable_type, :keyword_id, :the_note, the_note: [:quill])

			all_options = params.require(:article).fetch(:note, nil).try(:permit!)
   			params.require(:article).permit(:name, :plain_text, :image, :image_thumbnail, :short_description, :hashtags_names, :articable_id, :articable_type, :keyword_id).merge(:note => all_options)
		end

		def set_article
			@article = Article.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
		def set_s3_direct_post
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  		end
end
