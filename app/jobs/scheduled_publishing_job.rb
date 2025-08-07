class ScheduledPublishingJob < ApplicationJob
  queue_as :default

  def perform
    publish_scheduled_articles
    publish_scheduled_highlights
  end

  private

  def publish_scheduled_articles
    articles = Article.where(published: false, draft: 1)
                     .where("scheduled_time <= ?", Time.current)
                     .includes(:articable) # Carga eager loading para mejor performance

    articles.find_each do |article| # Usamos find_each para mejor manejo de memoria
      Article.transaction do
        # 1. Actualizar el artículo principal
        article.update_columns( # Usamos update_columns para saltar callbacks
          published: true,
          published_at: Time.current,
          draft: 2,
          updated_at: Time.current
        )

        # 2. Actualizar LatestArticle (sin limpiar caché)
        update_latest_articles(article)

        # 3. Actualizar CoverArticle (sin limpiar caché)
        update_cover_articles(article)
      end
    end
  end

  def update_latest_articles(article)
    latest_article = LatestArticle.order(published_at: :asc).first || LatestArticle.new
    
    latest_article.update_columns( # Saltamos validaciones y callbacks
      article_id: article.id,
      article_slug: article.slug,
      name: article.name,
      section_name: article.articable.name,
      section_slug: article.articable.slug,
      published_at: article.published_at,
      updated_at: Time.current
    )
  end

  def update_cover_articles(article)
    return unless article.articable&.visible?

    cover_article = CoverArticle.find_or_initialize_by(article_id: article.id)
    
    if cover_article.new_record?
      if CoverArticle.where(section_id: article.articable_id).count >= 20
        CoverArticle.where(section_id: article.articable_id)
                   .order(published_at: :asc)
                   .limit(1)
                   .delete_all
      end
    end

    cover_article.update_columns(
      article_image: article.image,
      article_slug: article.slug,
      name: article.name,
      article_highlight: false,
      published_at: article.published_at,
      section_id: article.articable_id,
      section_name: article.articable.name,
      section_slug: article.articable.slug,
      section_description: article.articable.description,
      article_exclusive: article.exclusive,
      section_color: article.articable.color,
      updated_at: Time.current
    )
  end

  def publish_scheduled_highlights
    Highlight.where(published: false)
            .where("scheduled_time <= ?", Time.current)
            .find_each do |highlight|
      Highlight.transaction do
        Highlight.where(
          order: highlight.order,
          location_id: highlight.location_id,
          published: true
        ).delete_all

        highlight.update_columns(
          published: true,
          updated_at: Time.current
        )
      end
    end
  end
end