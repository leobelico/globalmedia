class DeleteArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    c = CoverArticle.find_by(article_id: article.id)
	g = GlobalRecommendationArticle.find_by(article_id: article.id)
	m = MostVisitedArticle.find_by(article_id: article.id)
	l = LatestArticle.find_by(article_id: article.id)

	if c
    	c.destroy
    end

    if g
    	g.destroy
    end

    if m
    	m.destroy
    end

    if l
    	l.destroy
    end

  end
end
