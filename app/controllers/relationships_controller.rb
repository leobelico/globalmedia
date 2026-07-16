class RelationshipsController < ApplicationController
	before_action :set_relationship
def show
  @article_relationships = @relationship.article_relationships
                                          .includes(:article)
                                          .order(created_at: :desc)
                                          .paginate(page: params[:page], per_page: 20)
end
	def collaborators

		@collaborators = Relationship
											 .select('relationships.*, MAX(ar.updated_at) as most_recent_article')
											 .joins('inner join article_relationships ar on relationships.id = ar.articable_id and relationships.id != 34 AND relationships.id != 5')
											 .where(relationship_type: "Collaborator")
											 .order('most_recent_article DESC')
											 .group('relationships.id')
											 .paginate(page: params[:page], per_page: 18)
		@related_sections = RelatedSection.where(section: Section.find_by(name: "Colaboradores"))
	end
	private 
		def set_relationship
			if params[:id] == 'ANTONIO-GONZ-LEZ' or params[:id] == 'Juan-Antonio-Gonz-lez'
				params[:id] = ''
			end

			@relationship = Relationship.find_by(slug: params[:id])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url		
		end
end