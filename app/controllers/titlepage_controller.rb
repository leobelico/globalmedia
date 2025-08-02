class TitlepageController < ApplicationController
  before_action :authenticate_admin!, only: :publish_highlights

  def search_article
    article_id = params[:article_id]
    if article_id.to_s.include?("article_id")
      redirect_to search_results_path(params.dig(:article, :articable_id))
    else
      redirect_to Article.find(article_id)
    end
  end

  def privacy_policy; end

  def search_results
    @articles = Article.where('name ILIKE ?', "%#{params[:format]}%")
                       .where(published: true)
                       .order(created_at: :desc)
                       .paginate(page: params[:page], per_page: 20)
  end

  def about_us
    if (section = Section.find_by(name: "Acerca de"))
      @articles = Article.where(published: true, articable_id: section.id)
                         .paginate(page: params[:page], per_page: 9)
    end
  end

  def index
    location = get_current_location
    @location_id ||= 1
    puts "🌍 location en index: #{location&.key}, id: #{@location_id}"

    @breaking_news = Article.joins("INNER JOIN sections ON articles.articable_id = sections.id AND articles.articable_type = 'Section'")
                            .where(breaking_news: true, sections: { location_id: @location_id })
                            .order(updated_at: :desc)
                            .limit(4)

    @highlights = Highlight.includes(article: :articable)
                           .where(published: true, location_id: @location_id)
                           .order(:order)
                           .limit(6)

    @sections = Section.where(visible: true)
                       .where.not(name: "Último Momento")
                       .where(location_id: [nil, @location_id])
                       .where.not(id: location&.key == "san-luis" ? nil : 1025)
                       .order(:order)
                       .limit(20)

    @banner_poll = load_banner_poll(location)

    puts @banner_poll.to_s
  end

  def publish_highlights
    puts "publicando highlights"

    Highlight.transaction do
      Highlight.where("scheduled_time BETWEEN ? AND ?", 
                      150.minutes.ago.beginning_of_minute, 
                      Time.current.end_of_minute)
               .where(published: false)
               .order(:order)
               .each do |highlight|

        Highlight.where(published: true)
                 .where("highlights.order >= ?", highlight.order)
                 .order(:order)
                 .each_with_index do |h, i|
          h.update(order: highlight.order + i + 1)
        end

        if (seventh = Highlight.find_by(order: 7))
          seventh.update(published: false)
        end

        highlight.update(published: true)

        article = Article.find_by(id: highlight.article_id)
        article&.update(published: true)
      end
    end
  end

  # ⚠️ Estos dos métodos deberían ir a una tarea Rake, no ejecutarse desde web.
  def set_slug
    Article.where('id > 390').each do |article|
      if (image = Image.where(article_id: article.id).first)
        article.update(image: image.src)
      end
    end
  end

  def set_image
    Image.where('article_id > 390').each do |image|
      field = "https://globalmedia.mx/images/multimedia/#{image.src}"
      image.update(src: field)
    end
  end

  private

  def load_banner_poll(location)
    return default_banner unless location

    poll = {
      'is_open' => false,
      'image_url' => '',
      'poll_url' => '',
      'show_results' => false
    }

    if Preference.find_by(key: "#{location.key}_banner_polls_is_open")&.value == "true"
      poll['is_open'] = true
      poll['image_url'] = Preference.find_by(key: "#{location.key}_banner_polls_open_image")&.value
      poll_id = Preference.find_by(key: "#{location.key}_banner_polls_id")&.value

      poll['poll_url'] = if location.key == 'san-luis'
                           "https://www.globalmedia.mx/sections/QATAR-2022"
                         elsif poll_id.present?
                           "https://sondeosglobalmedia.com.mx/globalmedia_#{location.key}/?p=#{poll_id}"
                         else
                           ''
                         end
    end

    poll
  end

  def default_banner
    {
      'is_open' => false,
      'image_url' => '',
      'poll_url' => '',
      'show_results' => false
    }
  end
end
