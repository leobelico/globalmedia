desc "This task is called by the Heroku scheduler add-on to publish the articles"
task :publish_articles => :environment do
  articles = Article.where("scheduled_at = ? AND draft = ?", Time.now, false)
  articles.update_all(published: true)
end

task :remove_hashtags => :environment do
  hashtags = Hashtag.where(selected: true)
  hashtags.update_all(selected: false)
end