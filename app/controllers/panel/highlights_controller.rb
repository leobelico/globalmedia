class Panel::HighlightsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_highlight, only: [:edit, :update, :destroy]
	# load_and_authorize_resource
	before_action :check_news_chief
	
	autocomplete :article, :name, full: true
	before_action :get_all_highlights, only: [:new, :create, :edit, :update]
	def index
		@highlights = Highlight.where("highlights.order < 7").order(published: "DESC", scheduled_time: "DESC", order: "ASC").paginate(page: params[:page], per_page: 20)
	end

	def new
		@highlight = Highlight.new
	end

	def create

		@highlight = Highlight.new(highlight_params)

		##Lo primero que tenemos que hacer es revisar que no haya ese artículo ahorita

		existent_article_now = Highlight.where(article_id: params[:highlight][:article_id], published: true)
		if existent_article_now.count == 0
			##Luego checamos si ya hay un articulo con ese id en el futuro
			existent_article_in_future = Highlight.where("article_id = ? AND published = ? AND scheduled_time > ?", params[:highlight][:article_id], false, Time.now)
			if existent_article_in_future.count == 0
				is_order_created = Highlight.where(order: params[:highlight][:order], published: true)
				if is_order_created.count == 0
					@highlight.published = true
					if @highlight.save
						redirect_to panel_highlights_path
					else
						render action: "new"
					end
				else
					
					##vamos a mover los artículos
					scheduled_time = Time.new params[:highlight]["scheduled_time(1i)"].to_i, params[:highlight]["scheduled_time(2i)"].to_i, params[:highlight]["scheduled_time(3i)"].to_i, params[:highlight]["scheduled_time(4i)"].to_i, params[:highlight]["scheduled_time(5i)"].to_i 
					if scheduled_time >= Time.now.beginning_of_minute and scheduled_time <= Time.now.end_of_minute
						the_h = Highlight.where(order: params[:highlight][:order], published: true)
						highlights = Highlight.where(published: true)
						counter = the_h.first.order
							
						highlights.order(order: :asc).each do |h|
									
							if h.order >= counter and h.order < 6		
								h_to_mod = Highlight.where(order: h.order + 1, published: true).first
										
								h_to_mod.update_attributes(article_id: h.article_id)
										
										
							end
						end
						the_h.first.update_attributes(article_id: params[:highlight][:article_id])
						redirect_to panel_highlights_path
					else
						##Aquí el articulo se programa
						if @highlight.save
							redirect_to panel_highlights_path
						else
							render action: "new"
						end

					end
				end
				

			else
				flash[:notice] = "Ese artículo está programado para aparecer en el futuro."
				render action: "new"
			end
		else
			flash[:notice] = "Ya está la misma nota programada en portada."
			render action: "new"
		end
		
	end

	def edit

	end

	def update

		existent_article_now = Highlight.where(article_id: params[:highlight][:article_id], published: true)
		if existent_article_now.count == 0
			existent_article_in_future = Highlight.where("article_id = ? AND published = ? AND scheduled_time > ?", params[:highlight][:article_id], false, Time.now)
			if existent_article_in_future.count == 0
				if @highlight.update(highlight_params)
					redirect_to panel_highlights_path
				else
					flash[:notice] = "Hubo un error."
					render action: "edit"
				end
			else
				flash[:notice] = "Ese artículo está programado para aparecer en el futuro."
				render action: "edit"
			end

		else
			flash[:notice] = "Ya está la misma nota programada en portada."
			render action: "edit"
		end
		# scheduled_time = Time.new params[:highlight]["scheduled_time(1i)"].to_i, params[:highlight]["scheduled_time(2i)"].to_i, params[:highlight]["scheduled_time(3i)"].to_i, params[:highlight]["scheduled_time(4i)"].to_i, params[:highlight]["scheduled_time(5i)"].to_i 
		# p "TIME"
		# p scheduled_time
		# #article = Articles.find_by_name(params[:highlight][:article_id])
		# if !params[:highlight][:article_id].empty?
		# 	article = Article.find(params[:highlight][:article_id])
		
		
		# # p "---------------------"
		# # p article.id
		# # p "---------------------"
		# 	already_h = Highlight.where(article: article)
		# 	p "cuenta " + already_h.count.to_s

		# 	if already_h.count == 0
		# 		#si el artículo ya está publicado entonces recorre los otros que ya están publicados
		# 		if @highlight.published?
		# 			highlights = Highlight.where(published: true).last(6)
		# 			counter = @highlight.order
		# 			p "HIGHLIGHTSSS"
		# 			p highlights

		# 			p "counter"
		# 			p counter
		# 			highlights.each do |h|
		# 				p "ciclo"
		# 				p h.order
		# 				if h.order == counter and counter < 6
		# 					p "Entrando en el if"
		# 					h_to_mod = Highlight.where(order: counter + 1, published: true).first
		# 					p h_to_mod
		# 					p h_to_mod.article.name
		# 					h_to_mod.update_attributes(article_id: h.article.id)
		# 					p "MODIFICADO"
		# 					p h_to_mod
		# 					p h_to_mod.article.name
							
		# 				end
		# 				counter = counter + 1

						
		# 			end
		# 			@highlight.article_id = article.id
		# 			if @highlight.update(highlight_params)
		# 				redirect_to panel_highlights_path
		# 			else
		# 				render action: "edit"
		# 			end
		# 		else
		# 			if @highlight.update(highlight_params)
		# 				redirect_to panel_highlights_path
		# 			else
		# 				render action: "edit"
		# 			end
		# 		end
		# 	else
				
		# 		if Highlight.where(article_id: article.id, published: true).count == 0
		# 			p "timeee"
		# 			p already_h.first.scheduled_time
		# 			p scheduled_time
		# 			if already_h.first.scheduled_time > scheduled_time
		# 				flash[:notice] = "El artículo ya está en portada o está por publicarse en portada."
		# 				redirect_to panel_highlights_path
		# 			else

		# 				if @highlight.update_attributes(order: params[:highlight][:order], scheduled_time: scheduled_time, article: article)
		# 						redirect_to panel_highlights_path
		# 					else
		# 						render action: "edit"
		# 					end
		# 			end
		# 		else
		# 			flash[:notice] = "El artículo ya está en portada o está por publicarse en portada."
		# 				redirect_to panel_highlights_path
		# 		end
				

		# 	end
		# end
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
			params.require(:highlight).permit(:order, :article_id, :scheduled_time)

		end

		def get_all_highlights
			@highlights = Highlight.all.order(order: "ASC")
		end
end
