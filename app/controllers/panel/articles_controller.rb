class Panel::ArticlesController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_create_permission, only: [:new, :create, :edit, :update]
	before_action :check_delete_permission, only: [:destroy]
	before_action :set_article, only: [:show, :edit, :gallery_images, :update, :destroy]
	autocomplete :article, :name, full: true
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :gallery_images, :update]
	
	def publish_now
		@article = Article.find_by(slug: params[:article_slug])
		@article.update_attributes(published: true, draft: 1, published_at: DateTime.now)
		# expires_action :latest_news
		# Rails.cache.clear
		# Rails.cache.delete("views/section_articles/c9e9bc761f258191703f09bb6e30110c")
		# Rails.cache.delete("views/recent_articles/54f7eee5cf33ab592d78a02aade03259")
		redirect_to panel_articles_path
	end
	def index
		if params[:name]
			@articles = Article.where('lower(name) LIKE ?', "%#{params[:name]}%").paginate(page: params[:page], per_page: 20)
			p(params[:name])
		else 
			@articles = Article.all.order(created_at: "DESC").paginate(page: params[:page], per_page: 20)
			
		end
	end
	def set_highlight_from_id  
		article = Article.find(params[:article_id])
		if article.highlight == false
			article.update_attributes(highlight: true)
		else
			article.update_attributes(highlight: false)
		end	
		render json: { article: article }, status: :ok
	end
	def set_recommendation_from_id  
		article = Article.find(params[:article_id])
		if article.global_recommendation == false
			article.update_attributes(global_recommendation: true)
		else
			article.update_attributes(global_recommendation: false)
		end	
		render json: { article: article }, status: :ok
	end
	def gallery_images

	end
	def new
		@article = Article.new
	end

	def create

		@article = Articles.new(article_params)
		@article.user = current_user
		somedate = Time.zone.local(params[:scheduled_time_1i].to_i, 
                        params[:scheduled_time_2i].to_i,
                        params[:scheduled_time_3i].to_i,
                        params[:scheduled_time_4i].to_i,
                        params[:scheduled_time_5i].to_i, 0)
		@article.scheduled_time = somedate


		if @article.save

			@article.update_attribute(:published_at, @article.created_at) 
			if @article.draft == 2
			
				# Rails.cache.delete("views/section_articles/c9e9bc761f258191703f09bb6e30110c")
				# Rails.cache.delete("views/recent_articles/54f7eee5cf33ab592d78a02aade03259")

				@article.update_attributes(published: true) 

			end
			redirect_to edit_panel_article_path(@article)
		else
			respond_to do |format|
				format.json { render :json => { :error_message => @article.errors.full_messages }, :status => :unprocessable_entity }
			end	
		end
	end

	def show

	end

	def edit
		if @article.hashtags.count > 0	
			@hashtags = ""
			@article.hashtags.each_with_index do |hashtag, index|
				if index > 0
					@hashtags = @hashtags + ", " + hashtag.name
				else
					@hashtags = hashtag.name
				end
			end
		end
	end

	def update
		if params[:article][:note]
			@article.note = params[:article][:note]
		end
		if params[:scheduled_time_1i]
			somedate = Time.zone.local(params[:scheduled_time_1i].to_i, 
	                        params[:scheduled_time_2i].to_i,
	                        params[:scheduled_time_3i].to_i,
	                        params[:scheduled_time_4i].to_i,
	                        params[:scheduled_time_5i].to_i, 0)
		end

		if @article.update(article_params)
			if somedate 
				@article.update_attributes(scheduled_time: somedate)
			end
			if @article.draft == 0 or @article.draft == -1 
				@article.update_attributes(published: false)
			end
			if @article.draft == 2
				@article.update_attributes(published: true)
				p "PUBLICADO"
			end
			redirect_to @article
		else
			render action: "edit"
		end
	end

	def destroy
		@article.destroy
		# expires_action :latest_news
		# Rails.cache.delete("views/section_articles/c9e9bc761f258191703f09bb6e30110c")
		# Rails.cache.delete("views/recent_articles/54f7eee5cf33ab592d78a02aade03259")
		redirect_to panel_articles_path
		rescue ActiveRecord::InvalidForeignKey
    		flash[:notice] = "No se puede eliminar porque es nota de portada o recomendación global"
    		panel_articles_path
 		
	end

	def search_hashtag
		@search = Hashtag.find(params[:search])
		@hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
		

	end

	private
		def article_params
			params.require(:article).permit(:name, :exclusive, :note, :plain_text, :image, :image_thumbnail, :video_url, :short_description, :hashtags_names, :articable_id, :articable_type, :draft, :keyword_id, :global_recommendation, :the_note, :author_id, :breaking_news, the_note: [:quill], images_attributes: 
						[	
							:id, 
							:src, 
							:_destroy
						],  )

		end

		def set_article
			@article = Article.find_by_slug(params[:slug])
			if params[:article_slug] 
				@article = Article.find_by_slug(params[:article_slug])
			end
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
		def set_s3_direct_post
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  		end

  		def get_autocomplete_items(parameters)
      		items = active_record_get_autocomplete_items(parameters)
      		items = items.where(published: true)
    	end
  		
end
