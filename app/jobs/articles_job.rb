class ArticlesJob < ApplicationJob
  queue_as :default

  def perform()
     @articles = Article.where(published: true, created_at: Time.now.beginning_of_month..Time.now.end_of_month).order(created_at: "ASC").last(8).reverse

    ActionCable.server.broadcast 'latest_news', articles: @articles
  end

  def latest_news

  end
end
