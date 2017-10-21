class UpdateArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    g_article = GlobalRecommendationArticle.find_by(article_id: article.id)
    if g_article 
    	g_article.update_attributes(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, section_id: article.articable_id)
    end

    m_article = MostVisitedArticle.find_by(article_slug: article.slug)
    if m_article 
    	m_article.update_attributes(article_image: article.image, article_slug: article.slug, name: article.name)
    end

  end
end
