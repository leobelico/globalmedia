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
		if Section.find_by(name: "Acerca de")
			@articles = Article.where(published: true, articable_id: Section.find_by(name: "Acerca de").id).paginate(page: params[:page], per_page: 9)
		end
	end

	def set_slug
		Article.where('id > 390').each do |article|
			Image.where('article_id > 390').each do |image|
		       article.update_attributes(image: image.src)
			end
		end
	end

	def set_image
		Image.where('article_id > 390').each do |image|
			field = 'http://globalmedia.mx/images/multimedia/' + image.src
	       
	       image.update_attributes(src: field)
		end
	end

	def index
		@breaking_article = Section.where(visible: true).find_by(name: "Último Momento").articles.last
		@highlights = Highlight.where(published: true).order(order: "ASC")
		search = Hashtag.find_by_name("#ESNOTICIA")
		@its_news = ArticlesHashtag.where(hashtag_id: search).last(10)
		#@sections = Section.articles.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articable_id").where('highlights.article_id IS NULL')
		@sections = Section.where(visible: true).order(order: "ASC")

		relationships_investigations = Relationship.order(created_at: "ASC").where(relationship_type: "Investigation")

		p "relationships_investigations"
		p relationships_investigations
			@investigation_articles = []
		
		if relationships_investigations
			relationships_investigations.last(1).each do |relationship|
				@investigation_name = relationship.name
				relationship.article_relationships.last(6).each do |r|
					# p "ARTICLELALA"
					# p r.article
					@investigation_articles << r.article
				end
			end


		end
		p "INVESTIGATION ARTICLES"
		p @investigation_articles

 		section = Section.find_by_name("Denuncia Global")
		@complaints = Article.where(articable_id: section.id, published: true).order(updated_at: "ASC").last(6)


		@collaborator_articles = Article.joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id AND articles.published = true AND article_relationships.articable_type = 'Relationship' INNER JOIN relationships ON article_relationships.articable_id = relationships.id WHERE relationships.relationship_type= 'Collaborator' ORDER BY article_relationships.created_at DESC")
			# .order(created_at: "DESC").first(5)
	end

	def publish_highlights
		#este método saca todos los highlights que se publican ahora y pone en 
	
		
		Highlight.where("scheduled_time >= ? AND scheduled_time <= ? AND published = ?", Time.now.beginning_of_minute, Time.now.end_of_minute, false).all.each do |highlight|
			highlights_to_remove = Highlight.where(published: true, order: highlight.order)
			#highlights_to_remove.update_all(published: false)
			highlights = Highlight.where("published = ? AND highlights.order >= ?", true, highlight.order)

			counter = highlight.order

			highlights.each do |h|	
				counter = counter + 1
				h.update_attributes(order: counter)

			end

			seventh = Highlight.where(order: 7)
			if seventh 
				seventh.first.update_attributes(published: false)
			end
			highlight.update_attributes(published: true)

		end
	end
end
