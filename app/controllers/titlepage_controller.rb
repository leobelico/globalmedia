class TitlepageController < ApplicationController
	def search_article
		if params[:article_id].include? "article_id"
       
        	redirect_to search_results_path(params[:article][:articable_id])
    	else
	  		@article = Article.find(params[:article_id])
			redirect_to @article
      	end	
	end
	
	def search_results
		@articles = Article.where('lower(name) LIKE ? AND published = ? ', "%#{params[:format]}%", true).paginate(page: params[:page], per_page: 20)
	end

	def about_us 
	end
	def index
		@highlights = Highlight.all.order(order: "ASC")
		search = Hashtag.find_by_name("#ESNOTICIA")
		@its_news = ArticlesHashtag.where(hashtag_id: search).last(10)
		#@sections = Section.articles.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articable_id").where('highlights.article_id IS NULL')
		@sections = Section.where("name != 'Último Momento' AND name != 'Ultimo Momento' AND name != 'Denuncia Global' AND name != 'Estaciones' AND name != 'Colaboradores' AND name != 'Investigación Especial' AND name != 'INVESTIGACIÓN ESPECIAL' AND name != 'COLABORADORES' AND name != 'ESTACIONES'")

		relationships_investigations = Relationship.order(created_at: "ASC").where(relationship_type: "Investigation")

		p "relationships_investigations"
		p relationships_investigations
			@investigation_articles = []
		
		if relationships_investigations
			relationships_investigations.last(1).each do |relationship|
				@investigation_name = relationship.name
				relationship.article_relationships.last(6).each do |r|
					p "ARTICLELALA"
					p r.article
					@investigation_articles << r.article
				end
			end


		end
		p "INVESTIGATION ARTICLES"
		p @investigation_articles

 		section = Section.find_by_name("Denuncia Global")
		@complaints = Article.where(articable_id: section.id, published: true).order(updated_at: "ASC").last(6)

		@collaborator_articles = []

		collaborators = Relationship.where(relationship_type: "Collaborator").order(created_at: "ASC")

		# articles 
		collaborators.each do |collaborator|
			# collaborator.article_relationships.last.relationship.article 
			p "--------------------------------"
			p collaborator
			p "--------------------------------"
			if collaborator.article_relationships.last
				@collaborator_articles << collaborator.article_relationships.last.article
				@collaborator_articles = @collaborator_articles.last(5).reverse
			end
		end	

		# collaborators = Relationship.where(relationship_type: "Collaborator")

		# collaborator_article_relationships = []

		# collaborators.each do |collaborator|
		# 	collaborator_article_relationships << collaborator.article_relationships.last
		# end

		# collaborator_article_relationships.sort_by{|e| e[:created_at]}
		# collaborator_article_relationships.reverse
		# @collaborator_articles = [] 
		# collaborator_article_relationships.each do |carp|
		# 	@collaborator_articles << carp.article
		# end 

		# p "--------------------------------"
		# p "--------------------------------"
		# p @collaborator_articles
		# p "--------------------------------"
		# p "--------------------------------"

	end

end
