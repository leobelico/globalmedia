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
		@sections = Section.where('name != ?', "Último Momento")

		relationships_investigations = Relationship.where(relationship_type: "Investigation")

		p "relationships_investigations"
		p relationships_investigations
			@investigation_articles = []
		
		if relationships_investigations
			relationships_investigations.last(1).each do |relationship|
				relationship.article_relationships.last(6).each do |r|
					p "ARTICLELALA"
					p r.article
					@investigation_articles << r.article
				end
			end


		end
		p "INVESTIGATION ARTICLES"
		p @investigation_articles
 		
		@complaints = []

		complaint_relationships = Relationship.where(relationship_type: "Complaint")

		complaint_relationships.last(1).each do |relationship|
			relationship.article_relationships.last(6).each do |r|
				@complaints << r.article
			end
		end

		@collaborator_articles = []

		collaborators = Relationship.where(relationship_type: "Collaborator").order(created_at: "DESC")

		collaborators.each do |collaborator|
			# collaborator.article_relationships.last.relationship.article 
			p "--------------------------------"
			p collaborator
			p "--------------------------------"
			if collaborator.article_relationships.last
				@collaborator_articles << collaborator.article_relationships.last.article
				@collaborator_articles = @collaborator_articles.last(5)
			end
		end	


		p "--------------------------------"
		p "--------------------------------"
		p @collaborator_articles
		p "--------------------------------"
		p "--------------------------------"

	end

end
