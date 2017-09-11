desc "This task is called by the Heroku scheduler add-on to publish the articles"

task :publish_articles => :environment do
  articles = Article.where("scheduled_time >= ? AND scheduled_time <= ? AND draft = ?", (DateTime.now - 10.minutes).beginning_of_minute, DateTime.now.end_of_minute, 1)
  articles.update_all(published: true)
end

task :remove_hashtags => :environment do
  hashtags = Hashtag.where(selected: true)
  hashtags.update_all(selected: false)
end

task :publish_highlights => :environment do

	Highlight.where("scheduled_time >= ? AND scheduled_time <= ? AND published = ?", (DateTime.now.beginning_of_minute-10.minutes), (DateTime.now.end_of_minute), false).all.each do |highlight|
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