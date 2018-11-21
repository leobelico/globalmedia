class TitlepageController < ApplicationController
	before_action :authenticate_admin!, only: :publish_highlights
	def search_article
		if params[:article_id].include? "article_id"
       
        	redirect_to search_results_path(params[:article][:articable_id])
    	else
	  		@article = Article.find(params[:article_id])
			redirect_to @article
      	end	
	end
	def privacy_policy 
	end
	def search_results
		# @articles = Article.last(3)
		@articles = Article.where('name ILIKE ? AND published = ? ', "%#{params[:format]}%", true).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
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
			field = 'https://globalmedia.mx/images/multimedia/' + image.src
	       
	       image.update_attributes(src: field)
		end
	end

	def index
		@breaking_news = Article.where(breaking_news: true).order("articles.updated_at ASC").last(4).reverse
		
		@highlights = Highlight.where("published = ? AND highlights.order < 7", true).order(order: "ASC")
		
		#@sections = Section.articles.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articable_id").where('highlights.article_id IS NULL')
		@sections = Section.where("visible = 'true' AND name != 'Último Momento'").order(order: "ASC")

		
 		
	end

	def publish_highlights
		#este método saca todos los highlights que se publican ahora y pone en 
		p "publicando highlights"
		
		Highlight.where("scheduled_time >= ? AND scheduled_time <= ? AND published = ?", (DateTime.now.beginning_of_minute-150.minutes), (DateTime.now.end_of_minute), false).order(order: :asc).all.each do |highlight|
			
			highlights = Highlight.where("published = ? AND highlights.order >= ?", true, highlight.order).order(order: :asc)

			# highlights_to_remove = Highlight.where(published: true, order: highlight.order)
			# highlights_to_remove.update_all(published: false)
			

			counter = highlight.order

			highlights.each do |h|	
				counter = counter + 1
				h.update_attributes(order: counter)

			end

			seventh = Highlight.where(order: 7)
			if seventh.first 
				seventh.first.update_attributes(published: false)
			end
			highlight.update_attributes(published: true)
			if Article.exists?(highlight.article_id)
				Article.find(highlight.article_id).update_attribute(:published, true)
			end

		end

		
	end
end