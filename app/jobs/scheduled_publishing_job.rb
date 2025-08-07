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
                     .where("scheduled_time > ?", 10.minutes.ago)

    return Rails.logger.debug("No articles to publish") if articles.empty?

    updated_count = Article.transaction do
      articles.update_all(
        published: true,
        published_at: Time.current,
        draft: 2,
        updated_at: Time.current
      )
    end

    Rails.logger.info("[Article Publishing] Published #{updated_count} articles") if updated_count.positive?
  end

  def publish_scheduled_highlights
    pending_highlights = Highlight.where(published: false)
                                  .where("scheduled_time <= ?", Time.current)
                                  .where("scheduled_time > ?", 10.minutes.ago)

    return Rails.logger.debug("No highlights to publish") if pending_highlights.empty?

    count = 0

    Highlight.transaction do
      pending_highlights.each do |highlight|
        Highlight.where(
          order: highlight.order,
          location_id: highlight.location_id,
          published: true
        ).delete_all

        if highlight.update!(
            published: true,
            updated_at: Time.current
          )
          count += 1
        end
      end
    end

    Rails.logger.info("[Highlight Publishing] Published and replaced #{count} highlights")
  end
end
