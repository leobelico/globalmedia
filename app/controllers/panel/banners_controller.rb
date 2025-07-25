class Panel::BannersController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_banners_permission
	before_action :set_banner, only: [:show, :edit, :update, :destroy]
	before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]
	def index
		@banners = Banner.where('location_id = ?', @location_id).all
	end

	def new
		@banner = Banner.new	
	end

	def create
		@banner = Banner.new(banner_params)
		@banner.location_id = @location_id
		if @banner.save
			sections =  Section.where(id: params[:all_sections])
			p "cuenta de secciones"
			p sections.count
			sections.each do |section|
				p "creating"
				SectionBanner.create(banner: @banner, sectionable_id: section.id, sectionable_type: "Section")
			end
			stations =  Station.where(id: params[:all_stations])
			p "cuenta de secciones"
			p stations.count
			stations.each do |station|
				p "creating"
				SectionBanner.create(banner: @banner, sectionable_id: station.id, sectionable_type: "Station")
			end

			cameras =  Camera.where(id: params[:all_cameras])
			p "cuenta de secciones"
			p cameras.count
			cameras.each do |camera|
				p "creating"
				SectionBanner.create(banner: @banner, sectionable_id: camera.id, sectionable_type: "Camera")
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

			stations =  Station.where(id: params[:all_stations])
			p "cuenta de staciones"
			p stations.count
			stations.each do |station|
				p "creating"
				SectionBanner.create(banner: @banner, sectionable_id: station.id, sectionable_type: "Station")
			end


			cameras =  Camera.where(id: params[:all_cameras])
			p "cuenta de secciones"
			p cameras.count
			cameras.each do |camera|
				p "creating"
				SectionBanner.create(banner: @banner, sectionable_id: camera.id, sectionable_type: "Camera")
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
			params.require(:banner).permit(:large_image, :small_image, :size, :name, :client, :global, :titlepage, :url, :active, :expiry_date)
		end

		def set_banner
			@banner = Banner.find(params[:id])
		end
		def set_s3_direct_post
			one_year_in_seconds = 365 * 24 * 60 * 60
			one_year_from_now = Time.now + one_year_in_seconds
    		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', expires: one_year_from_now, cache_control: "max-age=#{one_year_in_seconds}")
  		end
end
