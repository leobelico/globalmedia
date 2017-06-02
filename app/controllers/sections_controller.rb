require 'will_paginate/array'
class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_section, only: [:show, :edit, :update, :destroy]
	
	def admin_show
		@section = Section.find(params[:format])
		@highlights = SectionHighlight.where(section: @section).order(updated_at: "DESC")
		
	end
	

	def show
		#articles = @section.articles	
		r_articles = []
    	SectionHighlight.where(section: @section).each do |section| 
      
       		 r_articles << section.article.id
      
   		 end

   		articles = []
   		Article.where(articable_id: @section.id, published: true).each do |article|
   			articles << article.id
   		end

   		most_visited = []

   		most_visited(@section.id).each do |article|
   			most_visited << article.id
   		end
   		@highlight = Article.where(articable_id: @section.id, highlight: true, published: true).order(updated_at: "DESC").first
  		@articles = Article.find(articles - r_articles - most_visited).paginate(page: params[:page], per_page: 20)

	end

	private		

		def set_section
			@section = Section.find_by_slug(params[:slug])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "La página que estabas buscando no existe."
				redirect_to root_url
		end
end
