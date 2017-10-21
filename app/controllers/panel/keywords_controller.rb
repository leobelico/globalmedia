class Panel::KeywordsController < ApplicationController
	before_action :authenticate_user!, except: [:show_keyword]
	# load_and_authorize_resource
	before_action :get_all_keywords, only: [ :edit_multiple]
	def index
		
	end

	def new
		@keywords = []
	    4.times do
	      @keywords << Keyword.new
	    end
	end

	def create
		params["keywords"].each do |keyword|
	    	
	    	Keyword.create(keyword_params(keyword))
	    	
 	 	end
 	 	Keyword.last(4).each do |keyword|
			keyword.update_attributes(slug: keyword.slug + "-" + keyword.id.to_s) 

 	 	end
 	 	redirect_to panel_keywords_path
	end

	# NOTAS DEL PROGRAMADOR 
	# En este proyecto todas las rutas y acciones por defecto son 
	# exclusivas de los administradores de la plataforma; 
	# para los usuarios finales usamos accion_modelo para la acción
	# como aquí a bajo se puede apreciar:
	# 
	# 	show_keyword
	# 
	# 

	def show
		@keyword = Keyword.find_by_slug(params[:slug])
	end
	
	def show_keyword
		@keyword = Keyword.find_by_slug(params[:keyword_slug])
	end

	def edit_multiple
	end

	def update_multiple
		#kw = params[:keyword].map{|e| {id: e[:id], keyword: e[:keyword]}}
		Keyword.update(params[:keyword].keys, params[:keyword].values)
    	redirect_to panel_keywords_path
	end


	private
		def keyword_params(my_params)
    		my_params.permit(:keyword)
  		end

  		def get_all_keywords
  			@keywords = Keyword.order(created_at: "ASC")
  		end
end
