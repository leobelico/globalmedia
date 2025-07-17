class TitlepageController < ApplicationController
  before_action :authenticate_admin!, only: :publish_highlights

  def search_article
    if params[:article_id].include? "article_id"
      redirect_to search_results_path(params[:article][:articable_id])
    else
      @article = Article.find(params[:article_id])
      redirect_to @article
    end
  end

  def privacy_policy; end

  def search_results
    @articles = Article.where('name ILIKE ? AND published = ?', "%#{params[:format]}%", true)
                       .order(created_at: :desc)
                       .paginate(page: params[:page], per_page: 20)
  end

  def about_us
    section = Section.find_by(name: "Acerca de")
    if section
      @articles = Article.where(published: true, articable_id: section.id)
                         .paginate(page: params[:page], per_page: 9)
    end
  end

  def set_slug
    Article.where('id > 390').each do |article|
      Image.where('article_id > 390').each do |image|
        article.update_attributes(image: image.src)
      end
    end
  end

  def set_image
    Image.where('article_id > 390').each do |image|
      field = 'https://globalmedia.mx/images/multimedia/' + image.src
      image.update_attributes(src: field)
    end
  end

def index
  location = get_current_location
  @location_id ||= 1
  puts "🌍 location en index: #{location&.key}, id: #{@location_id}"
    # Optimizado: limitamos breaking news y evitamos consultas innecesarias
	@breaking_news = Article.joins("INNER JOIN sections ON articles.articable_id = sections.id AND articles.articable_type = 'Section'")
                        .where(breaking_news: true, sections: { location_id: @location_id })
                        .order(updated_at: :desc)
                        .limit(4)


    # Highlights limitados a 6 para mejorar rendimiento
@highlights = Highlight.includes(article: :articable)
									.where(published: true, location_id: @location_id)
									.order(order: :asc)
									.limit(6)
									  puts "DEBUG HIGHLIGHTS ======="
 								 puts @highlights.inspect
    # Secciones filtradas, limitadas a 20 para evitar carga pesada
    if location&.key == "san-luis"
      @sections = Section.where(visible: true)
                         .where.not(name: "Último Momento")
                         .where(location_id: [nil, @location_id])
                         .order(:order)
                         .limit(20)
    else
      @sections = Section.where(visible: true)
                         .where.not(name: ["Último Momento"])
                         .where.not(id: 1025)
                         .where(location_id: [nil, @location_id])
                         .order(:order)
                         .limit(20)
    end

    @banner_poll = {
      'is_open' => false,
      'image_url' => '',
      'poll_url' => '',
      'show_results' => false
    }

    if location
      is_open = Preference.find_by(key: "#{location.key}_banner_polls_is_open")&.value
      if is_open == "true"
        @banner_poll['is_open'] = true
        @banner_poll['image_url'] = Preference.find_by(key: "#{location.key}_banner_polls_open_image")&.value
        poll_id = Preference.find_by(key: "#{location.key}_banner_polls_id")&.value
        if poll_id.present?
          if location.key == 'san-luis'
            @banner_poll['show_results'] = false
            @banner_poll['poll_url'] = "https://www.globalmedia.mx/sections/QATAR-2022"
          else
            @banner_poll['poll_url'] = "https://sondeosglobalmedia.com.mx/globalmedia_#{location.key}/?p=#{poll_id}"
          end
        end
      end
    end

    puts @banner_poll.to_s
  end

  def publish_highlights
    p "publicando highlights"

    Highlight.where("scheduled_time >= ? AND scheduled_time <= ? AND published = ?", 
                    (DateTime.now.beginning_of_minute - 150.minutes), 
                    DateTime.now.end_of_minute, 
                    false)
             .order(:order)
             .each do |highlight|

      highlights = Highlight.where("published = ? AND highlights.order >= ?", true, highlight.order).order(:order)

      counter = highlight.order
      highlights.each do |h|
        counter += 1
        h.update_attributes(order: counter)
      end

      seventh = Highlight.find_by(order: 7)
      seventh.update_attributes(published: false) if seventh

      highlight.update_attributes(published: true)
      Article.find(highlight.article_id).update_attribute(:published, true) if Article.exists?(highlight.article_id)
    end
  end
end
