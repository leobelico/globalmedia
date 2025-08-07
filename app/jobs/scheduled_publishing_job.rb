class ScheduledPublishingJob < ApplicationJob
  queue_as :default

  def perform
    publish_scheduled_articles
    publish_scheduled_highlights
    clear_caches
    # Asegurar que los cambios son visibles inmediatamente
    touch_application
  end

  private

  def publish_scheduled_articles
    articles = Article.where(published: false, draft: 1)
                     .where("scheduled_time <= ?", Time.current)
                     .where("scheduled_time > ?", 10.minutes.ago)
                     .order(scheduled_time: :asc) # Publicar en orden programado

    return Rails.logger.info("No articles to publish at #{Time.current}") if articles.empty?

    articles.each do |article|
      Article.transaction do
        article.update!(
          published: true,
          published_at: Time.current,
          draft: 2,
          updated_at: Time.current
        )

        update_latest_articles(article)
        update_cover_articles(article)
        
        # Limpiar cache específico para este artículo
        Rails.cache.delete("article_#{article.id}_cache")
      end
    end

    Rails.logger.info("[Article Publishing] Published #{articles.count} articles at #{Time.current}")
  end

  def update_latest_articles(article)
    # Bloquear la tabla para evitar condiciones de carrera
    LatestArticle.with_advisory_lock('latest_articles_update') do
      if LatestArticle.count < 8
        LatestArticle.create!(
          article_id: article.id,
          article_slug: article.slug,
          name: article.name,
          section_name: article.articable.name,
          section_slug: article.articable.slug,
          published_at: article.published_at
        )
      else
        # Encontrar el artículo más antiguo y reemplazarlo
        oldest = LatestArticle.order(published_at: :asc).first
        oldest.update!(
          article_id: article.id,
          article_slug: article.slug,
          name: article.name,
          section_name: article.articable.name,
          section_slug: article.articable.slug,
          published_at: article.published_at
        )
      end
    end
  end

  def update_cover_articles(article)
    return unless Section.where(visible: true).include?(article.articable)

    CoverArticle.with_advisory_lock('cover_articles_update') do
      cover_article = CoverArticle.find_or_initialize_by(article_id: article.id)
      
      if cover_article.new_record?
        if CoverArticle.where(section_id: article.articable_id).count >= 20
          # Eliminar el más antiguo que no sea destacado
          oldest = CoverArticle.where(section_id: article.articable_id, article_highlight: false)
                             .order(published_at: :asc)
                             .first
          oldest.destroy if oldest
        end
      end

      cover_article.update!(
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
    end
  end

  def publish_scheduled_highlights
    pending_highlights = Highlight.where(published: false)
                                .where("scheduled_time <= ?", Time.current)
                                .where("scheduled_time > ?", 10.minutes.ago)
                                .order(scheduled_time: :asc)

    return Rails.logger.info("No highlights to publish at #{Time.current}") if pending_highlights.empty?

    updated_count = Highlight.transaction do
      pending_highlights.each do |highlight|
        Highlight.where(
          order: highlight.order,
          location_id: highlight.location_id,
          published: true
        ).delete_all

        highlight.update!(
          published: true,
          updated_at: Time.current
        )
      end
    end

    Rails.logger.info("[Highlight Publishing] Published and replaced #{updated_count} highlights at #{Time.current}")
  end

  def clear_caches
    # Limpiar todos los cachés relacionados con artículos
    Rails.cache.delete_matched('homepage*')
    Rails.cache.delete_matched('section*')
    Rails.cache.delete('latest_articles')
    Rails.cache.delete('cover_articles')
    Rails.cache.delete('featured_articles')
    
    # Limpiar fragmentos de caché
    ActionController::Base.new.expire_fragment('homepage_articles')
    ActionController::Base.new.expire_fragment('main_sections')
    ActionController::Base.new.expire_fragment(/section_preview_.*/)
    
    # Si usas Russian Doll caching, toca el modelo para invalidar
    Article.touch_all if Article.respond_to?(:touch_all)
  end

  def touch_application
    # Esto fuerza a que la aplicación recargue todo
    FileUtils.touch(Rails.root.join('tmp/restart.txt'))
  rescue
    Rails.logger.warn("Could not touch restart.txt")
  end
end