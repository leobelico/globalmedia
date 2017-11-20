class UpdateArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    if article.published? 
      g_article = GlobalRecommendationArticle.find_by(article_id: article.id)
      if g_article 
      	g_article.update_attributes(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, section_id: article.articable_id)
      end

      m_article = MostVisitedArticle.find_by(article_slug: article.slug)
      if m_article 
      	m_article.update_attributes(article_image: article.image, article_slug: article.slug, name: article.name)
      end

      c_article = CoverArticle.find_by(article_slug: article.slug)
      if c_article 
        c_article.update_attributes(article_image: article.image, article_id: article.id, article_slug: article.slug, name: article.name, published_at: article.published_at, section_id: article.articable_id, section_name: article.articable.name, section_slug: article.articable.slug, section_description: article.articable.description, article_exclusive: article.exclusive, section_color: article.articable.color)
      end
    else
      g_article = GlobalRecommendationArticle.find_by(article_id: article.id)
      if g_article 
        g_article.destroy
      end

      m_article = MostVisitedArticle.find_by(article_slug: article.slug)
      if m_article 
        m_article.destroy
      end

      c_article = CoverArticle.find_by(article_slug: article.slug)
      if c_article 
        c_article.destroy
      end
    end

  end
end
