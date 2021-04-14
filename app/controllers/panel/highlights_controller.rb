class Panel::HighlightsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_highlight, only: [:edit, :update, :destroy]
	# load_and_authorize_resource
	before_action :check_news_chief
	
	autocomplete :article, :name, full: true
	before_action :get_all_highlights, only: [:new, :create, :edit, :update]
	def index
		@published = Highlight.where("published = ? AND highlights.order < 7 AND location_id = ?", true, @location_id).order(order: "ASC")
		@highlights = Highlight.where("highlights.order < 7 AND published = ? AND location_id = ?", false, @location_id).order(published: "DESC", scheduled_time: "DESC", order: "ASC").paginate(page: params[:page], per_page: 20)
	end
  def experimental

	end
	def new
		@highlight = Highlight.new
	end

	def create

		@highlight = Highlight.new(highlight_params)
		@highlight.location_id = @location_id
		##Lo primero que tenemos que hacer es revisar que no haya ese artículo ahorita

		existent_article_now = Highlight.where(article_id: params[:highlight][:article_id], published: true, location_id: @location_id)
		if existent_article_now.count == 0
			##Luego checamos si ya hay un articulo con ese id en el futuro
			existent_article_in_future = Highlight.where("article_id = ? AND published = ? AND scheduled_time > ? AND location_id = ?", params[:highlight][:article_id], false, Time.now, @location_id)
			if existent_article_in_future.count == 0
				is_order_created = Highlight.where(order: params[:highlight][:order], published: true, location_id: @location_id)
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
						the_h = Highlight.where(order: params[:highlight][:order], published: true, location_id: @location_id)
						highlights = Highlight.where(published: true, location_id: @location_id)
						counter = the_h.first.order
							
						highlights.order(order: :asc).each do |h|
									
							if h.order >= counter and h.order < 6		
								h_to_mod = Highlight.where(order: h.order + 1, published: true, location_id: @location_id).first
										
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

		existent_article_now = Highlight.where(article_id: params[:highlight][:article_id], published: true, location_id: @location_id)
		if existent_article_now.count == 0
			existent_article_in_future = Highlight.where("article_id = ? AND published = ? AND scheduled_time > ? AND location_id = ?", params[:highlight][:article_id], false, Time.now, @location_id)
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
	end

	def destroy
		if @highlight.published == false
			@highlight.destroy
		else
			flash[:notice] = "No se puede eliminar porque está en portada actualmente."

		end
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