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
		@breaking_news = Article.joins('INNER JOIN sections ON articles.articable_id = sections.id')
														.where('articles.breaking_news = ? AND sections.location_id = ?', true, @location_id).order("articles.updated_at ASC").last(4).reverse

		@highlights = Highlight.where("published = ? AND highlights.order < 7 AND location_id = ?", true, @location_id).order(order: "ASC")

		#@sections = Section.articles.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articable_id").where('highlights.article_id IS NULL')
		if get_current_location.key == "san-luis"
			@sections = Section.where("visible = 'true' AND name != 'Último Momento' AND (location_id IS NULL OR location_id = ?)", @location_id).order(order: "ASC")
		else
			@sections = Section.where("visible = 'true' AND name != 'Último Momento' AND id != 1025 AND (location_id IS NULL OR location_id = ?)", @location_id).order(order: "ASC")
		end


		@banner_poll = {
			'is_open' => false,
			'image_url' => '',
			'poll_url' => '',
			'show_results' => false
		}
		location = get_current_location
		is_open = Preference.where('key = ?', "#{location.key}_banner_polls_is_open").first
		if is_open != nil && is_open.value == "true"
			@banner_poll['is_open'] = true
			image = Preference.where('key = ?', "#{location.key}_banner_polls_open_image").first
			poll_id = Preference.where('key = ?', "#{location.key}_banner_polls_id").first
			if image != nil
				@banner_poll['image_url'] = image.value
			end
			if poll_id != nil
				if location.key == 'san-luis'
					#APARTADO PARA ACTIVAR EL MINI-BANNER - AQUI SE AGREGA LINK DEL BANNER GRANDE
					@banner_poll['show_results'] = false
					@banner_poll['poll_url'] = "https://www.globalmedia.mx/sections/QATAR-2022"
				else
					@banner_poll['poll_url'] = "https://sondeosglobalmedia.com.mx/globalmedia_#{location.key}/?p=#{poll_id.value}"
				end
			end
		end
		puts @banner_poll.to_s
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