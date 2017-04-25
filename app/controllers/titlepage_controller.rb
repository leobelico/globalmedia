class TitlepageController < ApplicationController
	def index
		@highlights = Highlight.all.order(order: "ASC")
		search = Hashtag.find_by_name("#ESNOTICIA")
		@its_news = ArticlesHashtag.where(hashtag_id: search).last(10)
		#@sections = Section.articles.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articable_id").where('highlights.article_id IS NULL')
		@sections = Section.where('name != ?', "Último Momento")

		relationships_investigations = Relationship.where(relationship_type: "Investigation").last.article_relationships

 		@investigation_articles = []

		relationships_investigations.last(6).each do |relationship|
			@investigation_articles << relationship.article
		end

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
