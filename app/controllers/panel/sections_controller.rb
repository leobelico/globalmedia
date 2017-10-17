class Panel::SectionsController < ApplicationController
	before_action :authenticate_user!
	# load_and_authorize_resource
	before_action :check_news_chief
	before_action :set_section, only: [:show, :edit, :update, :destroy, :set_highlight_from_id]
	autocomplete :article, :name, full: true
	
	def index
		@sections = Section.all.order(name: "ASC")

	end
	#SectionHighlight.create(article_id: article.id, section: section.id)

	def set_highlight_and_recomendations
		if params[:highlight]
			article = Article.find(params[:highlight])
		else
			article = Article.where(highlight: true).first
		end

		if params[:all_recommendations]
			articles =  Article.where(id: params[:all_recommendations])
			articles_in_highlights = SectionHighlight.where( section: articles.first.articable).order(created_at: "ASC")
			

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
				p "CUENTA"
				p articles_in_highlights.count
				if articles_in_highlights.count >= 5
					get_first_h = SectionHighlight.where(section: articles.first.articable).first(articles_in_highlights.count - 4)
					get_first_h.each do |h|
						"p destroying"
						h.destroy
					end 
				end
			
			if articles_in_highlights.count == 0
				articles.each do |this_article|
					SectionHighlights.create(article_id: this_article.id, section_id: this_article.articable.id )
				end
			end
		end

		current_articles = Article.where(articable: article.articable)
		current_articles.each do |a|
			if a != article
				
				a.update_attributes(highlight: false)
				
			end
		end

		if params[:highlight]
			
			article.update_attributes(highlight: true)

		end
		
	    
		redirect_back(fallback_location: root_url)

	end

	def show
		
		@highlight_article = CoverArticle.where(section_id: @section.id, article_highlight: true).first

		@highlights = SectionHighlight.where(section: @section).order(updated_at: "DESC")
		@recommendations = SectionHighlight.where(section: @section)
		@articles = Article.where(articable_id: @section.id).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
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

	def select_highlights

		@section = Section.find_by_slug(params[:section_slug])
		@highlight_article = Article.where(articable_id: @section.id, highlight: true).first
		
		session[:section_id] = @section.id

	end
	def set_highlight
		# Rails.cache.clear
		# Rails.cache.delete("views/section_articles/c9e9bc761f258191703f09bb6e30110c")
		# Rails.cache.delete("views/recent_articles/54f7eee5cf33ab592d78a02aade03259")

		# @section = Section.find_by_slug(params[:section_slug])
		# Article.where(articable_id: @section.id).update_all(highlight: false)
		
		article = Article.find(params[:panel][:article_id])
		# article.update_attributes(highlight: true)


		if Section.where(visible: true).include?(article.articable)
			
			last_article = CoverArticle.where(section_id: article.articable_id, article_highlight: true)
			if last_article
				last_article.delete_all
			end
			current_article = CoverArticle.find_by(article_id: article.id)
			if current_article
				current_article.update_attributes(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, section_id: article.articable_id, article_highlight: true, published_at: article.published_at, section_id: article.articable_id, section_name: article.articable.name, section_slug: article.articable.slug, section_description: article.articable.description, article_exclusive: article.exclusive, section_color: article.articable.color)
			else
				if CoverArticle.where(section_id: article.articable_id).count < 10
					CoverArticle.create(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, section_id: article.articable_id, article_highlight: true, published_at: article.published_at, section_id: article.articable_id, section_name: article.articable.name, section_slug: article.articable.slug, section_description: article.articable.description, article_exclusive: article.exclusive, section_color: article.articable.color)
				else
					last_article = CoverArticle.where(section_id: article.articable_id).order(published_at: :asc).last(10).reverse.last.destroy
					CoverArticle.create(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, section_id: article.articable_id, article_highlight: true, published_at: article.published_at, section_id: article.articable_id, section_name: article.articable.name, section_slug: article.articable.slug, section_description: article.articable.description, article_exclusive: article.exclusive, section_color: article.articable.color)
				end
			end
			
		end

		redirect_to panel_section_path(article.articable)

	end

	def select_global_recommendations

		@section = Section.find_by_slug(params[:section_slug])
		@recommendations = GlobalRecommendationArticle.where(section_id: @section.id)

		session[:section_id] = @section.id

	end
	def set_global_recommendations
		@section = Section.find_by_slug(params[:section_slug])
		@recommendations = GlobalRecommendationArticle.where(section_id: @section.id).delete_all
		GlobalRecommendationArticle.where(section_id: 1).delete_all
		
		if params[:panel][:first_article_id] != ""
			first_article = Article.find(params[:panel][:first_article_id])
			GlobalRecommendationArticle.create(name: first_article.name, article_slug: first_article.slug, article_image: first_article.image, section_id: @section.id, article_id: first_article.id)
		end
		if params[:panel][:second_article_id] != ""
			second_article = Article.find(params[:panel][:second_article_id])
			GlobalRecommendationArticle.create(name: second_article.name, article_slug: second_article.slug, article_image: second_article.image, section_id: @section.id, article_id: second_article.id)
			
		end
		if params[:panel][:third_article_id] != ""
			third_article = Article.find(params[:panel][:third_article_id])
			GlobalRecommendationArticle.create(name: third_article.name, article_slug: third_article.slug, article_image: third_article.image, section_id: @section.id, article_id: third_article.id)
			
		end

		redirect_to panel_section_path(@section)

	end
	def update
	
		if @section.update(section_params)

			sections =  Section.where(id: params[:all_sections])
			p "cuenta de secciones"
			p sections.count
			RelatedSection.where(section_id: @section.id).delete_all
			sections.each do |section|
				p "creating"
				RelatedSection.create(section_id: @section.id, section_reference_id: section.id)
			end
			redirect_to @section
		else
			render action: "edit"
		end
	end

	def destroy
		if @section.id == 1 or @section.id == 3 or @section.id == 4 or @section.id == 7 or @section.id == 5 or @section.id == 21 or @section.id == 1013 or @section.id == 1024 or @section.id == 1025 
			flash[:notice] = "Borrar está sección hará que crashee la página principal, llama a tu desarrollador"
			redirect_to root_url

		end 
		SectionHighlight.where(section: @section).delete_all
		HitObjective.where(section: @section).delete_all
		@section.destroy
		redirect_to root_url
	end

	private
		def section_params
			params.require(:section).permit(:name, :description, :color, :order, :visible, :facebook, :twitter)
		end

		def set_section
			@section = Section.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end

		def get_autocomplete_items(parameters)
      		items = active_record_get_autocomplete_items(parameters)
      		items = items.where(published: true, articable_id: session[:section_id], global_recommendation: false)
    	end
end