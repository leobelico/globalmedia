require 'will_paginate/array'
class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :sports, :corporation]
	before_action :set_section, only: [:show, :edit, :update, :destroy]
	
	def admin_show
		@section = Section.find(params[:format])
		@highlights = SectionHighlight.where(section: @section).order(updated_at: "DESC")
		
	end
	
	def sports
		session[:article_id] = nil
		if Section.find(1024)
			@intl = Section.find(1024) 
			@intl_articles = @intl.articles.last(6)
			@related_sections = RelatedSection.where(section: @intl)
		end 
		# if Section.find_by(name: "Táctica Internacional")
		# 	@intl = Section.find("Táctica Internacional") 
		# 	@intl_articles = @intl.articles.last(6)
		# 	@related_sections = RelatedSection.where(section: @intl)
		# end 
		if Section.find(1025)
			@local = Section.find(1025) 
			@local_articles = @local.articles.last(6)
		end
	end
	def corporation 
		session[:article_id] = nil
		@section = Section.find_by(slug: params[:format])
   		@highlight = Article.where(articable_id: @section.id, highlight: true, published: true).order(updated_at: "DESC").first
		@articles = @section.articles.paginate(page: params[:page], per_page: 3)
		if @highlight
			@note = @highlight.note
		end

	end 
	def show
		session[:article_id] = nil
		#articles = @section.articles	
		@related_sections = RelatedSection.where(section: @section)	
       
    	@first_article = Article.joins("INNER JOIN cover_articles ON cover_articles.article_id = articles.id").where("cover_articles.section_id = #{@section.id}").order("cover_articles.article_highlight desc, cover_articles.published_at desc").first
  		@articles = Article.where("published = true AND articable_id = ? AND published_at IS NOT NULL AND id != ?", @section.id, @first_article.id).order(published_at: :desc).paginate(page: params[:page], per_page: 12)

	end

	private		

		def set_section
			@section = Section.find_by_slug(params[:slug])
			if @section
			else
				redirect_to root_url
			end
		end
end
