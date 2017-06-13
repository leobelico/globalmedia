class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to panel_path, :alert => exception.message
  end

  
  autocomplete :article, :name, full: true

  def get_autocomplete_items(parameters)
      items = active_record_get_autocomplete_items(parameters)
      items = items.where(published: true)
  end

  helper_method :get_articles_per_section
  
  helper_method :al_momento
  helper_method :get_section_highlight
  helper_method :get_recommendations_per_section
  helper_method :get_latest_articles_per_section
  helper_method :get_global_recommendations
  helper_method :get_todays_keywords
  helper_method :get_banner
  helper_method :latest_news
  helper_method :most_visited
  helper_method :get_current_programs
  helper_method :check_hits_permission
  helper_method :check_create_permission
  helper_method :check_delete_permission
  helper_method :check_banners_permission
  helper_method :check_video_complaints_permission
  helper_method :check_radio_stations_permission
  helper_method :check_remote_controls_permission
  helper_method :check_news_chief
  helper_method :set_article
  helper_method :get_radio_stations
  helper_method :get_video_stations
  helper_method :get_news_stations
  

 
  helper_method :related_by_hashtags
  helper_method :get_sections

  def get_sections 
    @sections = Section.where(visible: true)
  end

  def related_by_hashtags(article)
    
    if article.hashtags.count == 1
       @articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND articles_hashtags.hashtag_id = #{ article.hashtags.first.id} AND articles.published = true AND articles.id != #{article.id}").last(3).uniq

    end

    if article.hashtags.count == 2
      @articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND (articles_hashtags.hashtag_id = #{ article.hashtags.first.id } OR articles_hashtags.hashtag_id = #{ article.hashtags.second.id }) AND articles.published = true AND articles.id != #{article.id}").last(3).uniq
    end 
    
    if article.hashtags.count >= 3
      @articles = Article.joins("INNER JOIN articles_hashtags ON articles_hashtags.article_id = articles.id AND (articles_hashtags.hashtag_id = #{ article.hashtags.first.id } OR articles_hashtags.hashtag_id = #{ article.hashtags.second.id } OR articles_hashtags.hashtag_id = #{ article.hashtags.third.id }) AND articles.published = true AND articles.id != #{article.id}").last(3).uniq
    end 
    # @hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
   
    return @articles

  end


  def get_radio_stations
    @radio_stations = Station.where(video: false, news: false).order(frequency: "ASC")
  end
  def get_video_stations 
    @video_stations = Station.where(video: true).order(frequency: "ASC")
  end
  def get_news_stations
    @news_stations = Station.where(news: true).order(frequency: "ASC")
  end
  def check_hits_permission
    if !current_user.hits_permission?
      redirect_to panel_path
    end
  end

  def check_create_permission
    if !current_user.create_articles_permission?
      redirect_to panel_path
    end
  end

  def check_delete_permission
    if !current_user.destroy_articles_permission?
      redirect_to panel_path
      end
  end

  def check_banners_permission
    if !current_user.banners_permission?
      redirect_to panel_path
      end
  end

  def check_remote_controls_permission
    if !current_user.remote_controls_permission?
      redirect_to panel_path
      end
  end

  def check_radio_stations_permission
    if !current_user.radio_stations_permission?
      redirect_to panel_path
      end
  end

  def check_video_complaints_permission
    if !current_user.video_complaints_permission?
      redirect_to panel_path
      end
  end

  def check_news_chief
    if !current_user.is_news_chief?
      redirect_to panel_path
      end
  end

  def get_articles_per_section(id, last_number)
    section = Section.find(id)
    # section.
    @articles = Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where("highlights.article_id IS NULL AND articles.articable_id = #{section.id} AND articles.highlight = false AND articles.global_recommendation = false AND articles.published = true").order(created_at: "ASC").last(last_number).reverse

  end
  def get_latest_articles_per_section(id, quantity)
    section = Section.find(id)
    articles = Article.where(articable_id: section.id, global_recommendation: false, published: true)
    recommendations = SectionHighlight.where(section: section)
    re = []
    recommendations.each do |r|
      re << r.article
    end
    
    @articles = articles - re
    return @articles.last(3)

  end


  def get_current_programs
    time = Time.now
    p "TIME"
    p time.strftime( "%H:%M")
    if time.sunday? 
      @timetables = Timetable.includes(:station).where("sunday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}'").order("stations.frequency asc").first(7)
    end
   
    if time.monday? 
      @timetables = Timetable.includes(:station).where("monday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}'").order("stations.frequency asc").first(7)
    end
   
    if time.tuesday? 
      @timetables = Timetable.includes(:station).where("tuesday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}'").order("stations.frequency asc").first(7)
    end
   
    if time.wednesday? 
      @timetables = Timetable.includes(:station).where("wednesday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}'").order("stations.frequency asc").first(7)
    end
   
    if time.thursday? 
      @timetables = Timetable.includes(:station).where("thursday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}'").order("stations.frequency asc").first(7)
    end
   
    if time.friday? 
      p "FRIDAY"
      @timetables = Timetable.includes(:station).where("friday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time }'").order("stations.frequency asc").first(7)
      p "TIMETABLESSSSSSSSSS"
      p @timetables
      p @timetables.count
    end
   
    if time.saturday? 
      @timetables = Timetable.includes(:station).where("saturday = 'true' AND streaming_hour < '#{time}' AND end_streaming_hour > '#{time}'").order("stations.frequency asc").first(7)
    end
   p "THE TIMETABLESSSSSSSSSS"
    p @timetables
  end

  def al_momento(not_repeat_highlight, not_repeat_recommendation, not_repeat_outstading, last_number)
  	if not_repeat_highlight
  		@articles = Article.order(created_at: "ASC").joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articles.highlight = false AND articles.global_recommendation = false AND articles.published = true').order(created_at: "DESC").last(last_number).reverse
  	end
  end

  def latest_news
    @articles = Article.where(published: true).last(8).reverse
  end
  
  def get_section_highlight(id)
    section = Section.find(id)
    @article = Article.where(articable: section, highlight: true).first
  end

  def get_recommendations_per_section(id)
    section = Section.find(id)
    @articles = []
    SectionHighlight.where(section: section).each do |section| 
        @articles << section.article
    end

    current_article = []
    if session[:article_id]
      current_article << Article.find(session[:article_id])
    end
    return @articles - current_article
    #SectionHighlight.where(section: section).last(3)
  end

  def get_global_recommendations
    @articles = Article.where(global_recommendation: true, published: true).order(updated_at: "ASC").last(4)

    current_article = []
    if session[:article_id]
      current_article << Article.find(session[:article_id])
    end

    return @articles - current_article
  end

  def get_todays_keywords
    @keywords = Hashtag.where(selected: true).last(4)
  end

  def get_banner(section, section_type, size)
    time = DateTime.now.to_date
    if section_type == "Global" or section_type == "TitlePage"
      if section_type == "Global"
        # @banners = Banner.where(global: true, size: size, active: true).reverse
        @banners = Banner.where("global = true AND size = '#{size}' AND active = 'true' AND expiry_date > '#{time}'").reverse
      else
        @banners = Banner.where("titlepage = 'true' AND size = '#{size}' AND active = 'true' AND expiry_date > '#{time}'").reverse
        # @banners = Banner.where(titlepage: true, size: size, active: true).reverse

      end 
    else
      p "GRANDEEEEEEEE"
      # @banner = Banner.joins("LEFT OUTER JOIN section_banners ON section_banners.banner_id = banners.id").where("banners.active = 'true' AND section_banners.sectionable_id = #{section.id} AND section_banners.sectionable_type = '#{section_type}' AND banners.size = '#{size}'").reverse
      @banner = Banner.joins("LEFT OUTER JOIN section_banners ON section_banners.banner_id = banners.id").where("banners.active = 'true' AND section_banners.sectionable_id = #{section.id} AND section_banners.sectionable_type = '#{section_type}' AND banners.size = '#{size}' AND banners.expiry_date > '#{time}'").reverse
      p "banner ilse"
      p @banner
    end

  end

  def most_visited(id)
    section = Section.find(id)
    #@hits = Hit.where(created_at: 2.hours.ago..Time.now).order(number: "ASC").last(3)
    articles = Article.joins("LEFT OUTER JOIN hits ON hits.article_id = articles.id").where("articles.published = true AND articles.highlight = false AND articles.global_recommendation = false AND hits.created_at > ? AND hits.created_at < ?", 2.hours.ago, Time.now)

    recommendations = SectionHighlight.where(section: section)
    re = []
    recommendations.each do |r|     
      re << r.article
    end

    current_article = []
    
    if session[:article_id]
      current_article << Article.find(session[:article_id])
    end

    @articles = articles - re - current_article
    return @articles.last(3)
  end

  def set_article
      @article = Article.find_by_slug(params[:slug])
      if @article 
        session[:article_id] = @article.id
      end
      
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "La página que estabas buscando no existe."
        redirect_to root_url
    end
end
