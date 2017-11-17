class RelationshipsController < ApplicationController
	before_action :set_relationship

	def show 
			
	end
	def collaborators

		@collaborators = Relationship.where(relationship_type: "Collaborator").order(updated_at: "DESC").paginate(page: params[:page], per_page: 18)
		@related_sections = RelatedSection.where(section: Section.find_by(name: "Colaboradores"))
	end
	private 
		def set_relationship 
			@relationship = Relationship.find_by(slug: params[:id])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url			
		end
end