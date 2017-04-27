class Panel::HitsController < ApplicationController
	before_action :authenticate_user!
	def index
		@hits = Hit.all
		
	end
end
