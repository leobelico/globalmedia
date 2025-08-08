class ScheduledPublishingJob < ApplicationJob
  queue_as :default

  def perform
    publish_scheduled_articles
    publish_scheduled_highlights
  end

  private

  def publish_scheduled_articles
    window_minutes = 10 # si quieres lo puedes hacer configurable con ENV

    articles = Article.where(published: false, draft: 1)
                      .where("scheduled_time <= ?", Time.current)
                      .where("scheduled_time > ?", window_minutes.minutes.ago)

    return Rails.logger.debug("No articles to publish") if articles.empty?

    Article.transaction do
      articles.each do |article|
        article.update!(
          published: true,
          published_at: Time.current,
          draft: 2,
          updated_at: Time.current
        )

        Rails.logger.debug("✅ Publicado: '#{article.name}' (ID: #{article.id}) a las #{article.published_at}")

        # === LATEST ARTICLE ===
        if LatestArticle.count < 8
          LatestArticle.create(
            article_id: article.id,
            article_slug: article.slug,
            name: article.name,
            section_name: article.articable.name,
            section_slug: article.articable.slug,
            published_at: article.published_at
          )
          Rails.logger.debug("🆕 Agregado a LatestArticles (total: #{LatestArticle.count})")
        else
          removed = LatestArticle.order(published_at: :asc).limit(1).first
          Rails.logger.debug("🗑️ Removido de LatestArticles: '#{removed.name}' (ID: #{removed.article_id})")
          removed.destroy
          LatestArticle.create(
            article_id: article.id,
            article_slug: article.slug,
            name: article.name,
            section_name: article.articable.name,
            section_slug: article.articable.slug,
            published_at: article.published_at
          )
          Rails.logger.debug("🔄 Agregado a LatestArticles reemplazando al más antiguo")
        end

        # === COVER ARTICLE ===
        if Section.where(visible: true).include?(article.articable)
          if CoverArticle.where(section_id: article.articable_id).count < 20
            CoverArticle.create(
              article_image: article.image,
              article_id: article.id,
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
            Rails.logger.debug("🆕 Agregado a CoverArticles en sección '#{article.articable.name}'")
          else
            removed = CoverArticle.where(section_id: article.articable_id, article_highlight: false)
                                  .order(published_at: :asc)
                                  .limit(1)
                                  .first
            Rails.logger.debug("🗑️ Removido de CoverArticles sección '#{article.articable.name}': '#{removed.name}' (ID: #{removed.article_id})")
            removed.destroy
            CoverArticle.create(
              article_image: article.image,
              article_id: article.id,
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
            Rails.logger.debug("🔄 Agregado a CoverArticles reemplazando al más antiguo de la sección '#{article.articable.name}'")
          end
        end
      end
    end

    Rails.logger.info("[Article Publishing] Published #{articles.count} articles")
  end

  def publish_scheduled_highlights
    window_minutes = 10

    pending_highlights = Highlight.where(published: false)
                                  .where("scheduled_time <= ?", Time.current)
                                  .where("scheduled_time > ?", window_minutes.minutes.ago)

    return Rails.logger.debug("No highlights to publish") if pending_highlights.empty?

    count = 0

    Highlight.transaction do
      pending_highlights.each do |highlight|
        replaced = Highlight.where(
          order: highlight.order,
          location_id: highlight.location_id,
          published: true
        )
        replaced.each do |old|
          Rails.logger.debug("🗑️ Removido highlight previo en posición #{old.order} de location #{old.location_id}")
        end
        replaced.delete_all

        if highlight.update!(published: true, updated_at: Time.current)
          Rails.logger.debug("⭐ Highlight publicado en posición #{highlight.order} de location #{highlight.location_id}")
          count += 1
        end
      end
    end

    Rails.logger.info("[Highlight Publishing] Published and replaced #{count} highlights")
  end
end
