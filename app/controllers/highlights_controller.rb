class HighlightsController < ApplicationController
	before_action :set_highlight, only: [:edit, :update, :destroy]
	autocomplete :article, :name, full: true, limit: 100
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
			redirect_to panel_highlights_path
		else
			render action: "new"
		end
	end

	def edit

	end

	def update
		p "cambiando"
		
		article = Article.find_by_name(params[:highlight][:article_id])
		p "article id " + article.id.to_s
		p "cuenta " + Highlight.where(article_id: article.id, published: true).count.to_s
		
		if Highlight.where(article_id: article.id, published: true).count >= 1
			@highlight.article = article
			if @highlight.update(highlight_params)
				redirect_to panel_highlights_path
			else
				render action: "edit"
			end
		else
			flash[:notice] = "Ese artículo ya está en portadas"
			redirect_to panel_highlights_path

		end
	end

	def destroy
		@highlight.destroy
		redirect_to panel_highlights_path
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

		def get_autocomplete_items(parameters)
      		items = active_record_get_autocomplete_items(parameters)
  		end
end