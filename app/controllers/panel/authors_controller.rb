class Panel::AuthorsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_news_chief
	before_action :set_author, only: [:show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]
	def index
		@authors = Author.where("name != 'Ninguno'")
	end

	def new
		@author = Author.new	
	end

	def create
		@author = Author.new(author_params)
		if @author.save
			
			redirect_to panel_authors_path
		else
			render action: "new"
		end
	end

	def edit

	end

	def update
		if @author.update(author_params)
			
			redirect_to panel_authors_path
		else
			render action: "edit"
		end
	end

	def destroy
		@author.destroy
		redirect_to panel_authors_path
	end

	private
		def author_params
			params.require(:author).permit(:name, :logo)
		end

		def set_author
			@author = Author.find(params[:id])
		end
		def set_s3_direct_post
			one_year_in_seconds = 365 * 24 * 60 * 60
			one_year_from_now = Time.now + one_year_in_seconds
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', expires: one_year_from_now, cache_control: "max-age=#{one_year_in_seconds}")
  		end
end
