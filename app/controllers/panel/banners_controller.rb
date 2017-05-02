class Panel::BannersController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_banners_permission
	before_action :set_banner, only: [:show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]
	def index
		@banners = Banner.all
	end

	def new
		@banner = Banner.new	
	end

	def create
		@banner = Banner.new(banner_params)
		if @banner.save
			sections =  Section.where(id: params[:all_sections])
			p "cuenta de secciones"
			p sections.count
			sections.each do |section|
				p "creating"
				SectionBanner.create(banner: @banner, sectionable_id: section.id, sectionable_type: "Section")
			end
			redirect_to panel_banner_path(@banner)
		else
			render action: "new"
		end
	end

	def edit

	end

	def update
		if @banner.update(banner_params)
			banners_in_sections = SectionBanner.where(banner: @banner)
			banners_in_sections.each do |banner|
				banner.destroy
			end
			sections =  Section.where(id: params[:all_sections])
			sections.each do |section|
				SectionBanner.create(banner: @banner, sectionable_id: section.id, sectionable_type: "Section")
			end
			redirect_to panel_banner_path(@banner)
		else
			render action: "edit"
		end
	end

	def destroy
		@banner.destroy
		redirect_to panel_banners_path
	end

	private
		def banner_params
			params.require(:banner).permit(:large_image, :small_image, :size, :name, :client, :global, :titlepage, :url)
		end

		def set_banner
			@banner = Banner.find(params[:id])
		end
		def set_s3_direct_post
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  		end
end
