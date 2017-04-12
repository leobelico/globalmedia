class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_section, only: [:show, :edit, :update, :destroy]
	
	def admin_show
		@section = Section.find(params[:format])

	end
	def set_highlight_and_recomendations
		@section = Sectios.find(params[:format])
	end

	def show
	end

	def new
		@section = Section.new
	end

	def create
		@section = Section.new(section_params)
		if @section.save 
			redirect_to @section
		else
			render action: "new"
		end
	end

	def edit
	end

	def update
	
		if @section.update(section_params)
			redirect_to @section
		else
			render action: "edit"
		end
	end

	def destroy
		@section.destroy
		redirect_to root_url
	end


	private
		def section_params
			params.require(:section).permit(:name)
		end

		def set_section
			@section = Section.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
