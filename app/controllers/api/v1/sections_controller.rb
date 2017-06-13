class Api::V1::SectionsController < Api::BaseController
	before_action :set_section, only: [:show]
	def index 
	    @sections = Section.where("name != 'Último Momento' AND name != 'Ultimo Momento' AND name != 'Denuncia Global' AND name != 'Estaciones' AND name != 'Colaboradores' AND name != 'Investigación Especial' AND name != 'INVESTIGACIÓN ESPECIAL' AND name != 'COLABORADORES' AND name != 'ESTACIONES'")
	    json_response(@sections, :ok)
	end
	def show 
    	paginate json: @section.articles.where(published: true), adapter: :json, per_page: 20		
	end

	def get_articles 
		section = Section.find(params[:section_id]) 
		@articles = section.articles.where(published: true).order(created_at: "DESC")
    	paginate json: @articles, adapter: :json, per_page: 20
	end
	private 
		def set_section
			@section = Section.find(params[:id])
		end
end
