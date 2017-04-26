class RelationshipsController < ApplicationController
	before_action :set_relationship

	def show 
	end

	private 
		def set_relationship 
			@relationship = Relationship.find_by(slug: params[:id])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url			
		end
end