class Panel::RelationshipsController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_video_complaints_permission, only: [:complaints, :new_complaint]
	before_action :check_news_chief, only: [:index, :new]
	before_action :set_relationship, only: [:show, :edit, :update, :destroy]
	before_action :set_new, only: [:new, :new_collaborator, :new_complaint]
	before_action :set_s3_direct_post, only: [:new_complaint, :new_collaborator, :new, :create, :edit, :update]

	def index
		@investigations = Relationship.where(relationship_type: "Investigation").order(created_at: "DESC").paginate(page: params[:page], per_page: 20)
	end

	def collaborators
		@collaborators = Relationship.where(relationship_type: "Collaborator").order(created_at: "DESC").paginate(page: params[:page], per_page: 20)
	end

	def complaints
		@complaints = Relationship.where(relationship_type: "Complaint").order(created_at: "DESC").paginate(page: params[:page], per_page: 20)
	end
	def new
		
	end

	def new_collaborator
	end
	def new_complaint
	end

	def create
		@relationship = Relationship.new(relationship_params)
		if @relationship.save

			@relationship.update_attributes(slug: @relationship.slug + "-" + @relationship.id.to_s) 
			
				redirect_to panel_relationship_path(@relationship)
			
		else
			render action: "new"
		end
	end

	def show

	end

	def edit
		
	end

	def update
		
		if @relationship.update(relationship_params)
			
				redirect_to panel_relationship_path(@relationship)
			
		else
			render action: "edit"
		end
	end

	def destroy
		@relationship.destroy
		redirect_to panel_path
	end

	
	
	def add_article_to_investigations
		@investigation = Relationship.find_by_slug(params[:format])
	end

	def set_investigation_articles
		expires_action :get_investigation_articles
		
		investigation = Relationship.find(params[:panel][:investigation_id])
		
		first_article = Article.find(params[:panel][:first_article_id])
		if investigation.id
			r = ArticleRelationship.create(article: first_article, articable_id: investigation.id, articable_type: "Relationship" )
		else
			flash[:error] = "No se pudo guardar, intenta de nuevo."
		end
		#Article.all.each do |article|
		#		article.update_attributes(global_recommendation: false)
		#	end
		redirect_to panel_relationship_path(investigation)
		
	end


	private
		def relationship_params
			params.require(:relationship).permit(:name, :image, :description, :relationship_type)

		end
		def set_new
			@relationship = Relationship.new
		end
		def set_relationship
			@relationship = Relationship.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
		def set_s3_direct_post
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  		end


end
