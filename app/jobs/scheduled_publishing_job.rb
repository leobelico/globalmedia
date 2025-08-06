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
    highlights = Highlight.where(published: false)
                         .where("scheduled_time <= ?", Time.current)
                         .where("scheduled_time > ?", 10.minutes.ago)

    return Rails.logger.debug("No highlights to publish") if highlights.empty?

    updated_count = Highlight.transaction do
      highlights.update_all(
        published: true,
        published_at: Time.current,
        updated_at: Time.current
      )
    end

    Rails.logger.info("[Highlight Publishing] Published #{updated_count} highlights") if updated_count.positive?
  end
end