class Panel::HitsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_hits_permission
	# load_and_authorize_resource
	def index
		@hits = Hit.all
		@hit_objectives = HitObjective.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)	
	end
	def authors 
	
	end 
	

end
