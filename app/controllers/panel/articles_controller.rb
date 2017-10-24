class Panel::ArticlesController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_create_permission, only: [:new, :create, :edit, :update]
	before_action :check_delete_permission, only: [:destroy]
	before_action :set_article, only: [:show, :edit, :gallery_images, :update, :destroy]
	autocomplete :article, :slug
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :gallery_images, :update]
	
	def publish_now
		@article = Article.find_by(slug: params[:article_slug])
		@article.update_attributes(published: true, draft: 1, published_at: DateTime.now)

		if LatestArticle.count < 8
			LatestArticle.create(article_id: @article.id, article_slug: @article.slug, name: @article.name, section_name: @article.articable.name, section_slug: @article.articable.slug, published_at: @article.published_at)
		else
			last_article = LatestArticle.order(published_at: :asc).last(8).reverse.last.destroy
			LatestArticle.create(article_id: @article.id, article_slug: @article.slug, name: @article.name, section_name: @article.articable.name, section_slug: @article.articable.slug, published_at: @article.published_at)
		end	

		if Section.where(visible: true).include?(@article.articable)
			if CoverArticle.where(section_id: @article.articable_id).count < 20
				CoverArticle.create(article_image: @article.image, article_id: @article.id, article_slug: @article.slug, name: @article.name, article_highlight: false, published_at: @article.published_at, section_id: @article.articable_id, section_name: @article.articable.name, section_slug: @article.articable.slug, section_description: @article.articable.description, article_exclusive: @article.exclusive, section_color: @article.articable.color)
			else
				last_article = CoverArticle.where(section_id: @article.articable_id, article_highlight: false).order(published_at: :asc).last(20).reverse.last.destroy
				CoverArticle.create(article_image: @article.image, article_id: @article.id, article_slug: @article.slug, name: @article.name, article_highlight: false, published_at: @article.published_at, section_id: @article.articable_id, section_name: @article.articable.name, section_slug: @article.articable.slug, section_description: @article.articable.description, article_exclusive: @article.exclusive, section_color: @article.articable.color)
			end
		end

		redirect_to panel_articles_path
	end
	def index
		if params[:name]
			@articles = Article.where('slug LIKE ?', "%#{params[:name]}%").paginate(page: params[:page], per_page: 10)
			# p(params[:name])
		else 
			@articles = Article.limit(1000).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
			
		end
	end
	def set_highlight_from_id  
		article = Article.find(params[:article_id])
		if article.highlight == false
			article.update_attributes(highlight: true)
			Article.where('id != ? and articable_id = ?', article.id, article.articable_id).update_all(highlight: false)
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

		@article = Article.new(article_params)
		@article.user = current_user
		somedate = Time.zone.local(params[:scheduled_time_1i].to_i, 
                        params[:scheduled_time_2i].to_i,
                        params[:scheduled_time_3i].to_i,
                        params[:scheduled_time_4i].to_i,
                        params[:scheduled_time_5i].to_i, 0)
		@article.scheduled_time = somedate
		if params[:article][:draft].to_i == 2
			@article.published = true	
		end

		@article.published_at = Time.now
		if @article.save
			if @article.published? 	

				#ESTO CREA LOS ARTICULOS QUE VAN A IR EN EL COVER
				if Section.where(visible: true).include?(@article.articable)
					if CoverArticle.where(section_id: @article.articable_id).count < 20
						CoverArticle.create(article_image: @article.image, article_id: @article.id, article_slug: @article.slug, name: @article.name, article_highlight: false, published_at: @article.published_at, section_id: @article.articable_id, section_name: @article.articable.name, section_slug: @article.articable.slug, section_description: @article.articable.description, article_exclusive: @article.exclusive, section_color: @article.articable.color)
					else
						last_article = CoverArticle.where(section_id: @article.articable_id, article_highlight: false).order(published_at: :asc).last(20).reverse.last.destroy
						CoverArticle.create(article_image: @article.image, article_id: @article.id, article_slug: @article.slug, name: @article.name, article_highlight: false, published_at: @article.published_at, section_id: @article.articable_id, section_name: @article.articable.name, section_slug: @article.articable.slug, section_description: @article.articable.description, article_exclusive: @article.exclusive, section_color: @article.articable.color)
					end
				end
				if LatestArticle.count < 8
					LatestArticle.create(article_id: @article.id, article_slug: @article.slug, name: @article.name, section_name: @article.articable.name, section_slug: @article.articable.slug, published_at: @article.published_at)
				else
					last_article = LatestArticle.order(published_at: :asc).last(8).reverse.last.destroy
					LatestArticle.create(article_id: @article.id, article_slug: @article.slug, name: @article.name, section_name: @article.articable.name, section_slug: @article.articable.slug, published_at: @article.published_at)
				end	
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

		if somedate 
			@article.scheduled_time = somedate
		end

		if params[:article][:draft].to_i == 0 or params[:article][:draft].to_i == -1
			@article.published = false
		end

		if params[:article][:draft].to_i == 2
			@article.published = true
		end

		if @article.update(article_params)
			if @article.published? 	
				UpdateArticleJob.perform_later @article

				if Section.where(visible: true).include?(@article.articable)
					does_cover_article_exists = CoverArticle.where(article_id: @article.id)
					if does_cover_article_exists.count <= 0
						if CoverArticle.where(section_id: @article.articable_id).count < 20
							CoverArticle.create(article_image: @article.image, article_id: @article.id, article_slug: @article.slug, name: @article.name, article_highlight: false, published_at: @article.published_at, section_id: @article.articable_id, section_name: @article.articable.name, section_slug: @article.articable.slug, section_description: @article.articable.description, article_exclusive: @article.exclusive, section_color: @article.articable.color)
						else
							last_article = CoverArticle.where(section_id: @article.articable_id, article_highlight: false).order(published_at: :asc).last(20).reverse.last.destroy
							CoverArticle.create(article_image: @article.image, article_id: @article.id, article_slug: @article.slug, name: @article.name, article_highlight: false, published_at: @article.published_at, section_id: @article.articable_id, section_name: @article.articable.name, section_slug: @article.articable.slug, section_description: @article.articable.description, article_exclusive: @article.exclusive, section_color: @article.articable.color)
						end
					else
						does_cover_article_exists.first.update_attributes(article_image: @article.image, article_id: @article.id, article_slug: @article.slug, name: @article.name, published_at: @article.published_at, section_id: @article.articable_id, section_name: @article.articable.name, section_slug: @article.articable.slug, section_description: @article.articable.description, article_exclusive: @article.exclusive, section_color: @article.articable.color)
						
						

					end
				end

				does_article_exists = LatestArticle.where(article_id: @article.id)
				if does_article_exists.count <= 0
					#el artículo no existe entonces hay que crearlo
					if LatestArticle.count < 8
						LatestArticle.create(article_id: @article.id, article_slug: @article.slug, name: @article.name, section_name: @article.articable.name, section_slug: @article.articable.slug, published_at: @article.published_at)
					else
						last_article = LatestArticle.order(published_at: :asc).last(8).reverse.last.destroy
						LatestArticle.create(article_id: @article.id, article_slug: @article.slug, name: @article.name, section_name: @article.articable.name, section_slug: @article.articable.slug, published_at: @article.published_at)
					end	
				else
					does_article_exists.first.update_attributes(article_id: @article.id, article_slug: @article.slug, name: @article.name, section_name: @article.articable.name, section_slug: @article.articable.slug, published_at: @article.published_at)
				end
			end
			redirect_to @article
		else
			render action: "edit"
		end
	end

	def destroy
		DeleteArticleJob.perform_later @article
		
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
		@hashtags = ArticlesHashtag.where(hashtag_id:params[:search]).limit(20	)
		

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
			one_year_in_seconds = 365 * 24 * 60 * 60
			one_year_from_now = Time.now + one_year_in_seconds
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', expires: one_year_from_now, cache_control: "max-age=#{one_year_in_seconds}")
  		end

  		def get_autocomplete_items(parameters)
      		items = active_record_get_autocomplete_items(parameters)
      		items = items.where(published: true)
    	end
  		
end
