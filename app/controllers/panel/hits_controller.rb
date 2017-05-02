class Panel::HitsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_hits_permission
	# load_and_authorize_resource
	def index
		@hits = Hit.all
		
	end

	

end
