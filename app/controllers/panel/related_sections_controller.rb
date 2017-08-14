class Panel::RelatedSectionsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_section, except: [:index]

	def index
		@related_sections = RelatedSection.all 
	end

	def new
		@related_section = @section.related_sections.build
	end

	def create
		@related_section = @section.related_sections.build(related_section_params)
		@related_section.section_id = @section.id 
		@related_section.section_reference_id = related_section_params.section_reference_id

		if @related_section.save
			redirect_to edit_panel_section_path(@section)
		else
			render action: "edit"
		end
	end

	def edit
	end

	def update
		if @related_section.update(related_section_params)
			redirect_to edit_panel_section_path(@section)
		else
			render action: "edit"
		end
	end


	def destroy
	end

	

	private
		def set_section
			@section = Section.find_by(slug: params[:section_id])	

		end
		def related_section_params
			params.require(:related_section).permit(:section_reference_id)
		end
end
