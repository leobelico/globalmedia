class Panel::HighlightsController < ApplicationController
	before_action :set_highlight, only: [:edit, :update, :destroy]
	# load_and_authorize_resource
	before_action :check_news_chief
	
	autocomplete :article, :name, full: true
	before_action :get_all_highlights, only: [:new, :create, :edit, :update]
	def index
		@highlights = Highlight.all.order(order: "ASC")
	end

	def new
		@highlight = Highlight.new
	end

	def create

		@highlight = Highlight.new(highlight_params)
		article = Article.find_by_name(params[:highlight][:article_id])
		@highlight.article = article
		if @highlight.save
			redirect_to panel_highlights_path
		else
			render action: "new"
		end

	end

	def edit

	end

	def update

		
		#article = Articles.find_by_name(params[:highlight][:article_id])
		article = Article.find(params[:highlight][:article_id])
		# p "---------------------"
		# p article.id
		# p "---------------------"
		@highlight.article_id = article.id
		if @highlight.update_attributes(article: article, order: params[:highlight][:order])
			redirect_to panel_highlights_path
		else
			render action: "edit"
		end
	end

	def destroy
		@highlight.destroy
		redirect_to panel_highlights_path
	end

	private
		def set_highlight
			@highlight = Highlight.find(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end

		def highlight_params
			params.require(:highlight).permit(:order, :article_id)

		end

		def get_all_highlights
			@highlights = Highlight.all.order(order: "ASC")
		end
end
