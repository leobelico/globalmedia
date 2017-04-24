class Panel::InvestigationsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_investigation, only: [:show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]

	def index
		@investigations = Investigation.all.order(created_at: "DESC").paginate(page: params[:page], per_page: 20)
	end

	def new
		@investigation = Investigation.new
	end

	def create
		@investigation = Investigation.new(investigation_params)

		if @investigation.save
			@investigation.update_attributes(slug: @investigation.slug + "-" + @investigation.id.to_s) 
			redirect_to panel_investigation_path(@investigation)
		else
			render action: "new"
		end
	end

	def show

	end

	def edit
		
	end

	def update
		
		if @investigation.update(investigation_params)
			redirect_to panel_investigation_path(@investigation)
		else
			render action: "edit"
		end
	end

	def destroy
		@investigation.destroy
		redirect_to panel_investigations_path
	end
	def add_article_to_investigations
		@investigation = Investigation.find_by_slug(params[:format])
	end

	def set_investigation_articles
		investigation = Investigation.find(params[:panel][:investigation_id])
		
		first_article = Article.find_by_name(params[:panel][:first_article_id])
		first_article.update_attributes(investigation_id: investigation.id)

		#Article.all.each do |article|
		#		article.update_attributes(global_recommendation: false)
		#	end
		redirect_to panel_investigation_path(investigation)
		
	end
	def search_hashtag
		@search = Hashtag.find(params[:search])
		@hashtags = investigationsHashtag.where(hashtag_id:params[:search])
		

	end

	private
		def investigation_params
			params.require(:investigation).permit(:name, :image, :description)

		end

		def set_investigation
			@investigation = Investigation.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
		def set_s3_direct_post
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  		end
end
