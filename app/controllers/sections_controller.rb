class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_section, only: [:show, :edit, :update, :destroy]
	
	def admin_show
		@section = Section.find(params[:format])
		@highlights = SectionHighlight.where(section: @section).order(updated_at: "DESC")
	end
	

	def show
		@articles = @section.articles.paginate(page: params[:page], per_page: 18) 	
	end

	


	private
		

		def set_section
			@section = Section.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
