class KeywordsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :get_all_keywords, only: [:index, :edit_multiple]
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
	    	if keyword["keyword"] != ""
	      		Keyword.create(keyword_params(keyword))
	    	end
 	 	end
 	 	redirect_to keywords_path
	end

	
	def edit_multiple
	end

	def update_multiple
		Keyword.update(params[:keyword].keys, params[:keyword].values)
    	
    	redirect_to keywords_path
	end

	private
		def keyword_params(my_params)
    		my_params.permit(:keyword)
  		end

  		def get_all_keywords
  			@keywords = Keyword.order(created_at: "ASC")
  		end
end
