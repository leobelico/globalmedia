class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :san_luis
  helper_method :seguridad
  helper_method :nacional
  helper_method :internacional
  helper_method :farandula
  helper_method :tactica
  helper_method :negocios
  helper_method :estados
  helper_method :actualidad
  helper_method :mundo_tecnologico
  helper_method :al_momento
  helper_method :get_section_highlight
  helper_method :get_recommendations_per_section
  helper_method :get_global_recommendations
  helper_method :get_todays_keywords


  def san_luis(last_number)
  	@san_luis = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 1 AND highlight = false').last(last_number)
  end

  def seguridad(last_number)
  	@seguridad = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 2 AND highlight = false').last(last_number)
  end

  def nacional(last_number)
  	@nacional = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 3 AND highlight = false').last(last_number)
  end

  def internacional(last_number)
  	@internacional= Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 4 AND highlight = false').last(last_number)

  end

  def farandula(last_number)
  	@farandula= Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 5 AND highlight = false').last(last_number)
  end

  def tactica(last_number)
  	@tactica = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 6 AND highlight = false').last(last_number)
  end

  def negocios(last_number)
  	@negocios = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 7 AND highlight = false').last(last_number)

  end

  def estados(last_number)
	@estados = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 8 AND highlight = false').last(last_number)
	
  end

  def actualidad(last_number)
  	@actualidad = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 9 AND highlight = false').last(last_number)
  end

  def mundo_tecnologico(last_number)
  	@mundo_tecnologico = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articable_id = 10 AND highlight = false').last(last_number)
  end

  def al_momento(not_repeat_highlight, not_repeat_recommendation, not_repeat_outstading, last_number)
  	if not_repeat_highlight
  		@articles = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL').order(created_at: "DESC").last(last_number)
  	end
  end

  def get_section_highlight(section_name)
    section = Section.find_by_name(section_name)
    @article = Article.where(articable: section, highlight: true).first
  end

  def get_recommendations_per_section(section_name)
    section = Section.find_by_name(section_name)
    @articles = Article.joins("LEFT OUTER JOIN section_highlights ON section_highlights.article_id = articles.id").where("section_highlights.article_id IS NULL AND articles.highlight = false AND articles.articable_id = #{section.id}") 
    #SectionHighlight.where(section: section).last(3)
  end

  def get_global_recommendations
    @articles = Article.where(global_recommendation: true).order(updated_at: "ASC").last(3)
  end

  def get_todays_keywords
    @keywords = Keyword.where('keyword != ?', '').order(created_at: "ASC")
  end

end
