require 'will_paginate/array'
class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :sports, :corporation]
	before_action :set_section, only: [:corporation, :show, :edit, :update, :destroy]
	
	def admin_show
		@section = Section.find(params[:format])
		@highlights = SectionHighlight.where(section: @section).order(updated_at: "DESC")
		
	end
	
	def sports
		if Section.find_by(name: "Táctica Nacional e Internacional")
			@intl = Section.find_by(name: "Táctica Nacional e Internacional") 
			@intl_articles = @intl.articles.last(6)
			@related_sections = RelatedSection.where(section: @intl)
		end 
		if Section.find_by(name: "Táctica Internacional")
			@intl = Section.find_by(name: "Táctica Internacional") 
			@intl_articles = @intl.articles.last(6)
			@related_sections = RelatedSection.where(section: @intl)
		end 
		if Section.find_by(name: "Táctica Local")
			@local = Section.find_by(name: "Táctica Local") 
			@local_articles = @local.articles.last(6)
		end
	end
	def corporation 
		@section = Section.find_by(slug: params[:format])
   		@highlight = Article.where(articable_id: @section.id, highlight: true, published: true).order(updated_at: "DESC").first
		@articles = @section.articles.paginate(page: params[:page], per_page: 3)
		if @highlight
			@note = @highlight.note
		end

	end 
	def show
		#articles = @section.articles	
		@related_sections = RelatedSection.where(section: @section)
		r_articles = []
    	SectionHighlight.where(section: @section).each do |section| 
      
       		r_articles << section.article.id
      
   		 end

   		articles = []
   		Article.where(articable_id: @section.id, published: true).last(200).each do |article|
   			articles << article.id
   		end

   		most_visited = []

   		most_visited(@section.id).each do |article|
   			most_visited << article.id
   		end
   		@highlight = Article.where(articable_id: @section.id, highlight: true, published: true).order(updated_at: "DESC").first
  		@articles = Article.find(articles - r_articles - most_visited).paginate(page: params[:page], per_page: 21)

	end

	private		

		def set_section
			@section = Section.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
