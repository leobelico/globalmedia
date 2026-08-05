class MostVisitedArticlesJob < ApplicationJob
  queue_as :default

  def perform
    articles = Article
      .joins("LEFT OUTER JOIN hits ON hits.article_id = articles.id")
      .where(
        "articles.published = true AND articles.articable_id != 5 AND articles.articable_id != 21 " \
        "AND articles.highlight = false AND articles.global_recommendation = ? " \
        "AND hits.created_at > ? AND hits.created_at < ?",
        false, 2.hours.ago, Time.now
      )
      .order("hits.number")
      .last(3)

    MostVisitedArticle.destroy_all if MostVisitedArticle.any?

    articles.each do |article|
      next if article.global_recommendation

      MostVisitedArticle.create(
        article_slug: article.slug,
        name: article.name,
        article_image: article.image,
        article_id: article.id
      )
    end
  end
end