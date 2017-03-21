class HighlightsController < ApplicationController
	before_action :set_highlight, only: [:edit, :update, :destroy]
	autocomplete :article, :name, full: true
	before_action :get_all_highlights, only: [:new, :create, :edit, :update]
	def index
		@highlights = Highlight.all
	end
	def new
		@highlight = Highlight.new
	end

	def create

		@highlight = Highlight.new(highlight_params)
		article = Article.find_by_name(params[:highlight][:article_id])
		@highlight.article = article
		if @highlight.save
			redirect_to highlights_path
		else
			render action: "new"
		end
	end

	def edit

	end

	def update

		
		article = Article.find_by_name(params[:highlight][:article_id])

		@highlight.article = article
		if @highlight.update(highlight_params)
			redirect_to highlights_path
		else
			render action: "edit"
		end
	end

	def destroy
		@highlight.destroy
		redirect_to highlights_path
	end

	private
		def set_highlight
			@highlight = Highlight.find(params[:id])
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
