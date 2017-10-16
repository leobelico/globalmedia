desc "This task is called by the Heroku scheduler add-on to publish the articles"

task :publish_articles => :environment do
  articles = Article.where("scheduled_time >= ? AND scheduled_time <= ? AND draft = ?", (DateTime.now - 10.minutes).beginning_of_minute, DateTime.now.end_of_minute, 1)
  articles.update_all(published: true, published_at: DateTime.now)
  articles.each do |article|
	  if LatestArticle.count < 8
			LatestArticle.create(article_id: article.id, article_slug: article.slug, name: article.name, section_name: article.articable.name, section_slug: article.articable.slug, published_at: article.published_at)
		else
			last_article = LatestArticle.order(published_at: :asc).last(8).reverse.last.destroy
			LatestArticle.create(article_id: article.id, article_slug: article.slug, name: article.name, section_name: article.articable.name, section_slug: article.articable.slug, published_at: article.published_at)
		end

		
	end
  
end

task :remove_hashtags => :environment do
  hashtags = Hashtag.where(selected: true)
  hashtags.update_all(selected: false)
end

task :publish_highlights => :environment do

	Highlight.where("scheduled_time >= ? AND scheduled_time <= ? AND published = ?", (DateTime.now.beginning_of_minute-10.minutes), (DateTime.now.end_of_minute), false).all.each do |highlight|
		highlights_to_remove = Highlight.where(published: true, order: highlight.order)
		highlights_to_remove.update_all(published: false)
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
		if Article.exists?(highlight.article_id)
			Article.find(highlight.article_id).update_attribute(:published, true)
		end

	end
end


task :most_visited => :environment do 
	articles = Article.joins("LEFT OUTER JOIN hits ON hits.article_id = articles.id").where("articles.published = true AND articles.highlight = false AND articles.global_recommendation = ? AND hits.created_at > ? AND hits.created_at < ?", false,2.hours.ago, Time.now).order("hits.number").last(4)
	if MostVisitedArticle.all.count >= 1
		MostVisitedArticle.destroy_all
	end
	articles.each do |article|
		if article.global_recommendation == false
			MostVisitedArticle.create(article_slug: article.slug, name: article.name, article_image: article.image)
		end
	end

end