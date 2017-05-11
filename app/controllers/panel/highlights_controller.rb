class Panel::HighlightsController < ApplicationController
	before_action :authenticate_user!
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
		the_h = Highlight.where(order: params[:highlight][:order])
		articles_already_in_highlight = Highlight.where(article: article)
		if articles_already_in_highlight.count <= 0
			if the_h.count <= 0
				@highlight.article = article
				if @highlight.save
					redirect_to panel_highlights_path
				else
					render action: "new"
				end
			else
				highlights = Highlight.last(6)
				counter = the_h.first.order
				p "HIGHLIGHTSSS"
				p highlights

				p "counter"
				p counter
				highlights.each do |h|
					p "ciclo"
					p h.order
					if h.order == counter and counter < 6
						p "Entrando en el if"
						h_to_mod = Highlight.where(order: counter + 1).first
						p h_to_mod
						p h_to_mod.article.name
						h_to_mod.update_attributes(article_id: h.article.id)
						p "MODIFICADO"
						p h_to_mod
						p h_to_mod.article.name
						
					end
					counter = counter + 1

					
				end
			
				the_h.first.article_id = article.id
				if the_h.first.update_attributes(article: article, order: params[:highlight][:order])
					

				

					redirect_to panel_highlights_path
				else
					render action: "new"
				end
				
			end
		else
			flash[:error] = "Ya está ese artículo en las notas destacadas."
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
		already_h = Highlight.where(article: article)
		if already_h.count == 0
			highlights = Highlight.last(6)
			counter = @highlight.order
			p "HIGHLIGHTSSS"
			p highlights

			p "counter"
			p counter
			highlights.each do |h|
				p "ciclo"
				p h.order
				if h.order == counter and counter < 6
					p "Entrando en el if"
					h_to_mod = Highlight.where(order: counter + 1).first
					p h_to_mod
					p h_to_mod.article.name
					h_to_mod.update_attributes(article_id: h.article.id)
					p "MODIFICADO"
					p h_to_mod
					p h_to_mod.article.name
					
				end
				counter = counter + 1

				
			end


			@highlight.article_id = article.id
			if @highlight.update_attributes(article: article, order: params[:highlight][:order])
				

			

				redirect_to panel_highlights_path
			else
				render action: "edit"
			end
		else
			flash[:notice] = "Esa noticia ya esta en highlights" 
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
