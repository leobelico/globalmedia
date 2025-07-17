module ArticlesHelper
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
