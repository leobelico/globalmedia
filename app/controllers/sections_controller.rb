class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_section, only: [:show, :edit, :update, :destroy]
	
	def admin_show
		@section = Section.find(params[:format])
		@highlights = SectionHighlight.where(section: @section).order(updated_at: "DESC")
	end
	def set_highlight_and_recomendations
		article = Article.find(params[:highlight])
		
		articles =  Article.where(id: params[:all_recommendations])
		articles_in_highlights = SectionHighlight.where(article_id: params[:all_recommendations], section: article.articable)
		if articles.count >= 4
			articles.each do |this_article|
				created = false
				articles_in_highlights.each do |a_in_h|
					if this_article == a_in_h.article
						created = true
					end
				end
				if created == false
					SectionHighlight.create(article_id: this_article.id, section_id: this_article.articable.id )
				end
			end

			if articles_in_highlights.count >= 4
				get_first_h = SectionHighlight.where(section: article.articable).first(articles_in_highlights.count - 3)
				get_first_h.each do |h|
					h.destroy
				end 
			end
		end

		current_articles = Article.where(articable: article.articable)
		current_articles.each do |a|
			if a != article
				p "UPDATING"
				p a.name
				a.update_attributes(highlight: false)
				p a.highlight
			end
		end
		article.update_attributes(highlight: true)
		p "ARTICLE highlight"
		p article.name
		p article.highlight
     
	    
		redirect_back(fallback_location: root_url)

	end

	def show
	end

	def new
		@section = Section.new
	end

	def create
		@section = Section.new(section_params)
		if @section.save 
			redirect_to @section
		else
			render action: "new"
		end
	end

	def edit
	end

	def update
	
		if @section.update(section_params)
			redirect_to @section
		else
			render action: "edit"
		end
	end

	def destroy
		@section.destroy
		redirect_to root_url
	end


	private
		def section_params
			params.require(:section).permit(:name)
		end

		def set_section
			@section = Section.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
