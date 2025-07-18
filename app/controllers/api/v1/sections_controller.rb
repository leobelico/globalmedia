class Api::V1::SectionsController < Api::BaseController
	before_action :set_section, only: [:show]
	def index 
	    @sections = Section.where("visible = true AND name != 'Último Momento' AND name != 'Ultimo Momento' AND name != 'Denuncia Global' AND name != 'Estaciones' AND name != 'Colaboradores' AND name != 'Investigación Especial' AND name != 'INVESTIGACIÓN ESPECIAL' AND name != 'COLABORADORES' AND name != 'ESTACIONES'").order(order: :asc)
	    json_response(@sections, :ok)
	end
	def show 
		# @articles = Article.where(articable_id: @section.id, published: true).order(created_at: "DESC")
		# # p "articles"
		# # p @articles
   		@articles = Article.joins("INNER JOIN cover_articles ON cover_articles.article_id = articles.id").where("cover_articles.section_id = ?", @section.id).order(created_at: :desc)

    	paginate json: @articles, adapter: :json, per_page: 20		
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
