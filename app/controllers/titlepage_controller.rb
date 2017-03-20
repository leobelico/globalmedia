class TitlepageController < ApplicationController
	def index
		@sections = Section.all
	end
end
