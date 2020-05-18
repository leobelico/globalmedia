class Panel::NewBannersController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_banners_permission
	def index

		# render :file => 'public/assets/ng/index.html'
	end

end
