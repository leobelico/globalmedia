class Panel::HitObjectivesController < ApplicationController
	before_action :authenticate_user!, except: [:show_keyword]
	
	def index
		@hit_objectives = HitObjective.all
		
	end

	def new
		@hit_objectives = []

	    Section.count.times do
	      @hit_objectives << HitObjective.new
	    end
	end

	def create
		params["hit_objectives"].each do |hit_objective|
	    	
	    	HitObjective.create(hit_objective_params(hit_objective))
	    	
 	 	end
 	 	
 	 	redirect_to panel_hit_objectives_path
	end

	# NOTAS DEL PROGRAMADOR 
	# En este proyecto todas las rutas y acciones por defecto son 
	# exclusivas de los administradores de la plataforma; 
	# para los usuarios finales usamos accion_modelo para la acción
	# como aquí a bajo se puede apreciar:
	# 
	# 	show_hit_objective
	# 
	# 

	def show
		@hit_objective = HitObjective.find_by_slug(params[:slug])
	end
	
	def show_hit_objective
		@hit_objective = HitObjective.find_by_slug(params[:hit_objective_slug])
	end

	def edit_multiple
		@hit_objectives = HitObjective.last(Section.all.count)
	end

	def update_multiple
		@hit_objectives = HitObjective.last(Section.all.count)
		#kw = params[:hit_objective].map{|e| {id: e[:id], hit_objective: e[:hit_objective]}}
		HitObjective.update(params[:hit_objectives].keys, params[:hit_objectives].values)
    	redirect_to panel_hit_objectives_path
	end


	private
		def hit_objective_params(my_params)
    		my_params.permit(:objective, :section_id)
  		end

  		def get_all_hit_objectives
  			@hit_objectives = hit_objective.order(created_at: "ASC")
  		end
end
