module ArticlesHelper
  # URL para og:image. Las fotos del bucket de S3 pasan por /og-image/:id, que las entrega con
  # el tipo correcto; las demás se usan directo.
  def social_image_url(article)
    source = social_image_source(article)
    if article.id && source.match?(SocialImagesController::ALLOWED_HOSTS_IN_URL)
      og_image_url(article.id, protocol: "https", host: "www.globalmedia.mx")
    else
      source
    end
  end

  # URL absoluta con https de la imagen original de la nota (WhatsApp y Facebook
  # no aceptan direcciones que empiezan con "//" ni con "http:").
  def social_image_source(article)
    src = article.image.to_s.strip
    url =
      if src.blank? then image_url("globalmedia.jpg")
      elsif src.start_with?("//") then "https:#{src}"
      elsif src.match?(%r{\Ahttps?://}i) then src
      else image_url(src)
      end
    url = "https:#{url}" if url.start_with?("//")
    url.sub(/\Ahttp:/i, "https:")
  end

  def social_image_type(url)
    case File.extname(URI.parse(url).path.to_s).downcase
    when ".png" then "image/png"
    when ".webp" then "image/webp"
    when ".gif" then "image/gif"
    else "image/jpeg"
    end
  rescue URI::InvalidURIError
    "image/jpeg"
  end

  def safe_image(article)
    article.image.presence || "default.jpg"
  rescue
    "default.jpg"
  end

  def safe_article_name(article)
    article.name.presence || "Artículo sin título"
  rescue
    "Artículo sin título"
  end

  def safe_section_name(article)
    article.articable&.name || "Sin sección"
  rescue
    "Sin sección"
  end

  def safe_article_time(article)
    distance_of_time_in_words(Time.now, article.published_at || article.created_at)
  rescue
    "-"
  end

  def safe_short_description(article)
    truncate(article.short_description.to_s, length: 240)
  rescue
    ""
  end

  def safe_article_path(article)
    article_path(article)
  rescue
    "#"
  end

  def article_exclusive?(article)
    article.exclusive?
  rescue
    false
  end
end
