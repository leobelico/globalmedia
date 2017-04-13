class BannersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_banner, only: [:show, :edit, :update, :destroy]
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
			redirect_to @banner
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
			redirect_to @banner
		else
			render action: "edit"
		end
	end

	def destroy
		@banner.destroy
		redirect_to @banner
	end

	private
		def banner_params
			params.require(:banner).permit(:large_image, :small_image, :size, :name )
		end

		def set_banner
			@banner = Banner.find(params[:id])
		end

end
