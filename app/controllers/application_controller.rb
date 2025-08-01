class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to panel_path, :alert => exception.message
  end

  before_action :redirect_subdomain

  @meta_description = ''
def redirect_subdomain
  if Rails.env.development?
    set_local_dev_location
    return
  end

  @meta_description = ''
  @subdomain_location = 'default'
  host = request.host

  # Dominio raíz sin subdominio (por ejemplo globalmedia.onrender.com o globalmedia.mx)
  if host.match?(/^globalmedia\.(onrender\.com|mx)$/)
    @location_id = 1 # San Luis Potosí
    return
  end

  # Detectar subdominio como leon.globalmedia.mx o leon.globalmedia.onrender.com
  subdomain_match = host.match(/^([a-zA-Z0-9-]+)\.globalmedia\.(onrender\.com|mx)$/)
  subdomain = subdomain_match[1] if subdomain_match

  case subdomain
  when 'leon'
    @location_id = 2
  when 'zacatecas'
    @location_id = 6
  when 'vallarta', 'jalisco'
    # Redirección a subdominio oficial: vallartabahia
    new_host = host.gsub(/(vallarta|jalisco)/, 'vallartabahia')
    redirect_to "#{request.protocol}#{new_host}#{request.fullpath}", status: 301 and return
  when 'vallartabahia'
    @location_id = 4
  else
    @location_id = 1 # Default: San Luis
  end

  # Intentar cargar datos del Location
  location = Location.find_by(id: @location_id)
  if location
    @meta_description = location.meta_description
    @subdomain_location = location.key
  else
    @meta_description = 'Noticias de hoy en San Luis Potosí, México y el mundo, sigue la información minuto a minuto desde San Luis Potosí GlobalMedia es noticia.'
  end
end

  # before_action do
  #   if user_signed_in?
  #     # Rack::MiniProfiler.authorize_request
  #   end
  # end

  autocomplete :article, :name, full: true

def set_local_dev_location
  @location_id = 1
  @meta_description = "Desarrollo local - San Luis Potosí"
  @subdomain_location = "san-luis"
end

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
  helper_method :get_children_programs
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
  helper_method :get_investigation_articles
  helper_method :get_collaborators
  helper_method :get_complaints
  helper_method :get_section_articles
  helper_method :get_cover_articles
  helper_method :get_current_location
  helper_method :get_local_section

  helper_method :current_coord

  def current_coord
    @current_coord = Geocoder.search("201.127.113.90").first.coordinates 
  end

  def get_children_programs(parent_id)
    time = Time.now
    result = []
    day_name = time.strftime('%A').downcase

    result = Timetable.includes(:station).where("#{day_name} = ? AND streaming_hour < ? AND parent_station_id = ? AND end_streaming_hour > ?", true, time, parent_id, time).order("stations.orderer asc").limit(7)
    result
  end
  def get_cover_articles(id)
    CoverArticle.joins("LEFT OUTER JOIN highlights ON highlights.article_id = cover_articles.article_id").where("cover_articles.section_id = #{id} AND highlights.article_id IS NULL AND cover_articles.published_at IS NOT NULL").order(article_highlight: :asc, published_at: :asc).last(4).reverse
    
  end
  def get_complaints
    
   @complaints = Section.find(11).articles.order(updated_at: "ASC").last(6).reverse
  end

  def get_collaborators
  return [] unless @location_id.present?

  Article.joins(:article_relationships)
         .joins("INNER JOIN relationships ON article_relationships.articable_id = relationships.id")
         .where(
           published: true,
           article_relationships: {
             articable_type: "Relationship",
             location_id: @location_id.to_i
           },
           relationships: {
             relationship_type: "Collaborator"
           }
         )
         .order("article_relationships.created_at DESC")
         .limit(7)
end


  def get_section_articles(id)


    Article.joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where("articles.created_at >= ? AND articles.created_at <= ? AND highlights.article_id IS NULL AND articles.articable_id = #{id} AND articles.published = true", (Date.today - 1.month).beginning_of_month, (Date.today).end_of_month).order(highlight: :asc, created_at: :asc).last(4).reverse     

  end
  
  def get_sections 
    @sections = Section.where(visible: true)
    
  end

  def related_by_hashtags(article) 
    if article.hashtags.first  
      @articles = article.hashtags.first.articles.last(4).pluck(:name, :slug, :id)
    end
    if @articles.count == 0 and article.hashtags.second
      @articles = article.hashtags.second.articles.last(4).pluck(:name, :slug, :id)

    end

    if @articles.count == 0 and article.hashtags.third
      @articles = article.hashtags.third.articles.last(4).pluck(:name, :slug, :id)

    end
    # @hashtags = ArticlesHashtag.where(hashtag_id:params[:search])
    # print "finish related_by_hashtags"
    # p @articles
    return @articles

  end

  def get_investigation_articles
    @articles = Article.limit(4000).joins("INNER JOIN article_relationships ON article_relationships.article_id = articles.id").joins("INNER JOIN relationships ON article_relationships.articable_id = relationships.id").where("relationships.relationship_type ='Investigation' AND relationships.id = ?", Relationship.order(created_at: "ASC").where(relationship_type: "Investigation").last.id ).order("article_relationships.created_at ASC").last(6).reverse


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
    

     # @articles = Article.where(articable_id: id).order(created_at: "ASC").last(last_number).reverse
    @articles = Article.joins("INNER JOIN cover_articles ON cover_articles.article_id = articles.id").where("cover_articles.section_id = #{id}").order(created_at: "ASC").last(3).reverse





   #@articles = Article.where(articable_id: id, created_at: Time.now.beginning_of_month..Time.now.end_of_month).first(last_number)

  end
  def get_latest_articles_per_section(id, quantity)
    # section = Section.find(id)
    articles = Article.joins("LEFT JOIN section_highlights ON section_highlights.article_id = articles.id").where("section_highlights.article_id IS NULL AND articles.articable_id = ? AND articles.global_recommendation = ? AND articles.published = ?", 1, false, true).order(created_at: "DESC").first(3)



  
    # p "finish get_latest_articles_per_section"
    return @articles

  end


  def get_current_programs
  day_name = Time.now.strftime('%A').downcase  # "sunday", "monday", etc.
  Timetable.includes(:station)
          .references(:station)
          .where("#{day_name} = ? AND streaming_hour < ? AND parent_station_id IS NULL AND end_streaming_hour > ?", true, Time.now, Time.now)
          .order("stations.orderer ASC")
          .limit(7)
end
def get_current_programs
  day_name = Time.now.strftime('%A').downcase  # "sunday", "monday", etc.
  Timetable.includes(:station)
           .where("#{day_name} = ? AND streaming_hour < ? AND parent_station_id IS NULL AND end_streaming_hour > ?", true, Time.now, Time.now)
           .order("stations.orderer ASC")
           .limit(7)
end

  def al_momento(not_repeat_highlight, not_repeat_recommendation, not_repeat_outstading, last_number)
    p "finish al_momento"
  	
    if not_repeat_highlight
  		@articles = Article.order(created_at: "ASC").joins("LEFT OUTER JOIN highlights ON highlights.article_id = articles.id").where('highlights.article_id IS NULL AND articles.highlight = false AND articles.global_recommendation = false AND articles.published = true').order(created_at: "DESC").last(last_number).reverse
  	end

  end

  def latest_news
    
    @articles = LatestArticle.all.sort_by{ |t| t.published_at }.last(8).reverse
    
  end
  
  def get_section_highlight(id)
    # p "finish get_section_highlight " + id.to_s

    # section = Section.find(id)
    @article = Article.where(articable_id: id, highlight: true, created_at: (Date.today - 1.month).beginning_of_month..(Date.today).end_of_month).order(updated_at: "DESC").first
  end

  def get_recommendations_per_section(id)
    @articles = Article.joins("INNER JOIN section_highlights ON section_highlights.article_id = articles.id").where("section_highlights.section_id = ? AND articles.id != ?", id, session[:article_id]).last(3)
  end

  def get_global_recommendations(id)
    
    if id != 0
      if session[:article_id]
        @articles = GlobalRecommendationArticle.where("section_id = ? AND article_id != ?", id, session[:article_id]).last(3) 
        if @articles.count == 0
           @articles = GlobalRecommendationArticle.where("global_recommendation = ? AND article_id != ?", true, session[:article_id]).last(3) 
        end
      else
        @articles = GlobalRecommendationArticle.where(section_id: id).last(3) 
        if @articles.count == 0
          @articles = GlobalRecommendationArticle.where(global_recommendation: true).last(3) 
        end
      end
    else
      if session[:article_id]
        @articles = GlobalRecommendationArticle.where("global_recommendation = ? AND article_id != ?", true, session[:article_id]).last(3)
      else
        @articles = GlobalRecommendationArticle.where(global_recommendation: true).last(3)

      end 
    end 

    return @articles
  end

  def get_todays_keywords
    # p "finish todays_keywords"

    @keywords = Hashtag.where(selected: true).last(4)

  end

  def get_banner(section, section_type, size)
    time = DateTime.now.to_date
    if section_type == "Global" or section_type == "TitlePage"
      if section_type == "Global"
        # @banners = Banner.where(global: true, size: size, active: true).reverse
        @banners = Banner.where("global = true AND size = '#{size}' AND active = 'true' AND expiry_date > '#{time}' AND banners.location_id = ?", @location_id).reverse
      else
        @banners = Banner.where("titlepage = 'true' AND size = '#{size}' AND active = 'true' AND expiry_date > '#{time}' AND banners.location_id = ?", @location_id).reverse
        # @banners = Banner.where(titlepage: true, size: size, active: true).reverse

      end 
    else
      # p "GRANDEEEEEEEE"
      # @banner = Banner.joins("LEFT OUTER JOIN section_banners ON section_banners.banner_id = banners.id").where("banners.active = 'true' AND section_banners.sectionable_id = #{section.id} AND section_banners.sectionable_type = '#{section_type}' AND banners.size = '#{size}'").reverse
      @banner = Banner.joins("LEFT OUTER JOIN section_banners ON section_banners.banner_id = banners.id")
                      .where("banners.active = 'true' AND section_banners.sectionable_id = #{section.id} AND section_banners.sectionable_type = '#{section_type}' AND banners.size = '#{size}' AND banners.expiry_date > '#{time}' AND banners.location_id = ?", @location_id).reverse
      # p "banner ilse"
      # p @banner
    end

  end

  def most_visited
  
      if session[:article_id]
        @articles = MostVisitedArticle.where("article_id != ?", session[:article_id]).last(3)
        
      else
        @articles = MostVisitedArticle.last(3)

      end

    return @articles 
    

  end

  def set_article
     if params[:slug].valid_encoding?
        @article = Article.find_by_slug(params[:slug])
        if @article 
          session[:article_id] = @article.id
        else
          redirect_to root_url
        end
      else
        redirect_to root_url
      end
      
     
  end

  def get_current_location
    if @current_location == nil
      @current_location = Location.where('id = ?', @location_id).first
    end
    @current_location
  end

  def get_local_section
    if @local_section == nil
      @local_section = Section.find_by(location_id: @location_id)
      if @local_section == nil
        @local_section = Section.find_by(id: 1)
      end
    end
    @local_section
  end
end
