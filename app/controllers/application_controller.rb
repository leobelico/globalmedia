class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :get_articles_per_section
  
  helper_method :al_momento
  helper_method :get_section_highlight
  helper_method :get_recommendations_per_section
  helper_method :get_global_recommendations
  helper_method :get_todays_keywords

  def get_articles_per_section(id, last_number)
    section = Section.find(id)
    @articles = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where("highlights.article_id IS NULL AND articles.articable_id = #{section.id} AND articles.highlight = false AND articles.global_recommendation = false").last(last_number)
  end
  
  def al_momento(not_repeat_highlight, not_repeat_recommendation, not_repeat_outstading, last_number)
  	if not_repeat_highlight
  		@articles = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articles.highlight = false AND articles.global_recommendation = false').order(created_at: "DESC").last(last_number)
  	end
  end

  def get_section_highlight(id)
    section = Section.find(id)
    @article = Article.where(articable: section, highlight: true).first
  end

  def get_recommendations_per_section(id)
    section = Section.find(id)
    @articles = Article.joins("LEFT OUTER JOIN section_highlights ON section_highlights.article_id = articles.id").where("section_highlights.article_id IS NULL AND articles.highlight = false AND global_recommendation = false AND articles.articable_id = #{section.id}") 
    #SectionHighlight.where(section: section).last(3)
  end

  def get_global_recommendations
    @articles = Article.where(global_recommendation: true).order(updated_at: "ASC").last(3)
  end

  def get_todays_keywords
    @keywords = Keyword.where('keyword != ?', '').order(created_at: "ASC")
  end

end
