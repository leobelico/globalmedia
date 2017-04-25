class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :get_articles_per_section
  
  helper_method :al_momento
  helper_method :get_section_highlight
  helper_method :get_recommendations_per_section
  helper_method :get_global_recommendations
  helper_method :get_todays_keywords
  helper_method :get_banner
  helper_method :latest_news

  def get_articles_per_section(id, last_number)
    section = Section.find(id)
    @articles = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where("highlights.article_id IS NULL AND articles.articable_id = #{section.id} AND articles.highlight = false AND articles.global_recommendation = false").last(last_number)
  end


  def al_momento(not_repeat_highlight, not_repeat_recommendation, not_repeat_outstading, last_number)
  	if not_repeat_highlight
  		@articles = Article.order(created_at: "ASC").joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articles.highlight = false AND articles.global_recommendation = false').order(created_at: "DESC").last(last_number).reverse
  	end
  end

  def latest_news
    @articles = Article.last(6).reverse
  end
  
  def get_section_highlight(id)
    section = Section.find(id)
    @article = Article.where(articable: section, highlight: true).first
  end

  def get_recommendations_per_section(id)
    section = Section.find(id)
    @articles = Article.joins("LEFT OUTER JOIN section_highlights ON section_highlights.article_id = articles.id").where("section_highlights.article_id IS NULL AND articles.highlight = false AND global_recommendation = false AND articles.articable_id = #{section.id}").last(3)
    #SectionHighlight.where(section: section).last(3)
  end

  def get_global_recommendations
    @articles = Article.where(global_recommendation: true).order(updated_at: "ASC").last(3)
  end

  def get_todays_keywords
    @keywords = Keyword.where('keyword != ?', '').order(created_at: "ASC").last(4)
  end

  def get_banner(section, section_type, size)
    if section_type == "Global" or section_type == "TitlePage"
      if section_type == "Global"
        @banner = Banner.where(global: true, size: size).last
      else
        @banner = Banner.where(titlepage: true, size: size).last

      end 
    else
      @banner = Banner.joins("LEFT OUTER JOIN section_banners ON section_banners.banner_id = banners.id").where(" section_banners.sectionable_id = #{section.id} AND section_banners.sectionable_type = '#{section_type}' AND banners.size = '#{size}'").last
    end

  end

end
