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

		if Section.where(visible: true).include?(article.articable)
			if CoverArticle.where(section_id: article.articable_id).count < 20
				CoverArticle.create(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, article_highlight: false, published_at: article.published_at, section_id: article.articable_id, section_name: article.articable.name, section_slug: article.articable.slug, section_description: article.articable.description, article_exclusive: article.exclusive, section_color: article.articable.color)
			else
				last_article = CoverArticle.where(section_id: article.articable_id).order(published_at: :asc).last(20).reverse.last
				if last_article
					last_article.destroy
				end
				CoverArticle.create(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, article_highlight: false, published_at: article.published_at, section_id: article.articable_id, section_name: article.articable.name, section_slug: article.articable.slug, section_description: article.articable.description, article_exclusive: article.exclusive, section_color: article.articable.color)
			end
		end	
	end
  
end

task :remove_hashtags => :environment do
  hashtags = Hashtag.where(selected: true)
  hashtags.update_all(selected: false)
end


task :publish_highlights => :environment do
	locations = Location.all
	order_from = 1
	order_to = 6
	now = DateTime.now
	locations.each do |location|
		counter = order_from
		while counter <= order_to
			latest_unpublished_highlight = Highlight.where("published = ? AND scheduled_time <= ? AND location_id = ? AND highlights.order = ?", false, now, location.id, counter).order('scheduled_time DESC').first
			if latest_unpublished_highlight != nil
				latest_published_highlight = Highlight.where("published = ? AND location_id = ? AND highlights.order = ?", true, location.id, counter).order('scheduled_time DESC').first
				if latest_published_highlight != nil
					if latest_published_highlight.scheduled_time.to_datetime <= latest_unpublished_highlight.scheduled_time.to_datetime
						latest_unpublished_highlight.update(published: true)
						latest_published_highlight = latest_unpublished_highlight
					end
				else
					latest_unpublished_highlight.update(published: true)
					latest_published_highlight = latest_unpublished_highlight
				end
				Highlight.where("scheduled_time <= ? AND location_id = ? AND highlights.order = ? AND id != ?", now, location.id, counter, latest_published_highlight.id).destroy_all
				if Article.exists?(latest_published_highlight.article_id)
					Article.find(latest_published_highlight.article_id).update_attribute(:published, true)
				end
			end
			counter += 1
		end
	end
end


task :most_visited => :environment do 
	articles = Article.joins("LEFT OUTER JOIN hits ON hits.article_id = articles.id").where("articles.published = true AND articles.articable_id != 5 AND articles.articable_id != 21 AND articles.highlight = false AND articles.global_recommendation = ? AND hits.created_at > ? AND hits.created_at < ?", false,2.hours.ago, Time.now).order("hits.number").last(3)
	if MostVisitedArticle.all.count >= 1
		MostVisitedArticle.destroy_all
	end
	articles.each do |article|
		if article.global_recommendation == false
			MostVisitedArticle.create(article_slug: article.slug, name: article.name, article_image: article.image, article_id: article.id)
		end
	end

end

task :update_sitemap_articles => :environment do
  host = 'https://www.globalmedia.mx'
  max_records_by_sitemap = 10000
  buffer_records = (max_records_by_sitemap / 5).to_i
  articles = Article.joins("LEFT JOIN sitemap_indexed_articles ON sitemap_indexed_articles.article_id = articles.id").where('articles.published = TRUE AND sitemap_indexed_articles.article_id IS NULL').order("articles.created_at ASC")
	articles_count = articles.count
  total_pages = articles_count % buffer_records == 0 ? (articles_count / buffer_records).to_i : (articles_count / buffer_records).to_i + 1

  last_index = SitemapIndex.order(id: 'DESC').first
  if last_index == nil
		last_index = SitemapIndex.create(lastmod: DateTime.now)
  end
	records_count = last_index.total_records
  for i in 0..total_pages
    articles_chunk = articles.offset(i * buffer_records).limit(buffer_records)
    sitemap_index_articles = []
    articles_chunk.each do |article|
			if records_count + 1 > max_records_by_sitemap
        last_index.total_records = records_count
        last_index.save
				last_index = SitemapIndex.create(lastmod: DateTime.now)
				records_count = last_index.total_records
      end
			records_count += 1
			sitemap_index_articles.push(
        {
          article_id: article.id,
          sitemap_index_id: last_index.id,
          loc: "#{host}/articles/#{article.slug}",
          lastmod: article.updated_at.to_datetime,
          created_at: DateTime.now,
          updated_at: DateTime.now,
        }
      )
    end
    news_len = sitemap_index_articles.count
    if news_len > 0
			SitemapIndexedArticle.insert_all(sitemap_index_articles)
			last_index.total_records = records_count
			last_index.save
    end
  end
  sitemap_indexes = SitemapIndex.all
  sitemap_indexes.each do |index|
    last_mod = SitemapIndexedArticle.where('sitemap_index_id = ? ', index.id).order('lastmod DESC').first
    if last_mod != nil
      tmp_idx = SitemapIndex.find_by(id: index.id)
			tmp_idx.update(lastmod: last_mod.lastmod)
    end
  end
end


task :remove_old_highlights => :environment do 
	Highlight.where("scheduled_time <= ?", Time.now - 48.hours).delete_all
end