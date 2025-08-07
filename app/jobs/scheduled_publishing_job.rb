class ScheduledPublishingJob < ApplicationJob
  queue_as :default

  def perform
    publish_scheduled_articles
    publish_scheduled_highlights
  end

  private

  def publish_scheduled_articles
    # Consulta optimizada con índices adecuados
    articles = Article.where(published: false, draft: 1)
                     .where("scheduled_time <= ?", Time.current)
                     .order(:id) # Ordenar por ID para consistencia
                     .limit(1000) # Limitar para evitar sobrecarga

    articles.find_each do |article| # Procesamiento por lotes
      Article.transaction do
        # 1. Actualizar artículo principal
        article.update_columns(
          published: true,
          published_at: Time.current,
          draft: 2,
          updated_at: Time.current
        )

        # 2. Actualizar LatestArticle (versión corregida)
        update_latest_articles(article)

        # 3. Actualizar CoverArticle
        update_cover_articles(article)
      end
    rescue => e
      Rails.logger.error("Error processing article #{article.id}: #{e.message}")
      raise # Reintentar el job si falla
    end
  end

  def update_latest_articles(article)
    latest_article = LatestArticle.order(published_at: :asc).first

    if latest_article
      latest_article.update_columns(
        article_id: article.id,
        article_slug: article.slug,
        name: article.name,
        section_name: article.articable.name,
        section_slug: article.articable.slug,
        published_at: article.published_at,
        updated_at: Time.current
      )
    else
      # Crear nuevo registro si no existe ninguno
      LatestArticle.create!(
        article_id: article.id,
        article_slug: article.slug,
        name: article.name,
        section_name: article.articable.name,
        section_slug: article.articable.slug,
        published_at: article.published_at
      )
    end
  end

  def update_cover_articles(article)
    return unless article.articable&.visible?

    cover_article = CoverArticle.find_or_initialize_by(article_id: article.id)
    
    if cover_article.new_record?
      # Eliminar el más antiguo si hay más de 20
      if CoverArticle.where(section_id: article.articable_id).count >= 20
        CoverArticle.where(section_id: article.articable_id)
                   .order(published_at: :asc)
                   .limit(1)
                   .delete_all
      end
      
      # Crear nuevo registro
      cover_article.assign_attributes(
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
        section_color: article.articable.color
      )
      cover_article.save!
    else
      # Actualizar registro existente
      cover_article.update_columns(
        published_at: article.published_at,
        updated_at: Time.current
      )
    end
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

        highlight.update!(published: true)
      end
    end
  end
end