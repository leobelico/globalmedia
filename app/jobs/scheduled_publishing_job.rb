class ScheduledPublishingJob < ApplicationJob
  queue_as :default

  def perform
    Article.where(published: false, draft: 1)
           .where("scheduled_time <= ?", Time.current)
           .find_each do |article|
      article.update(published: true, published_at: Time.current, draft: 2)
      Rails.logger.info("Artículo publicado automáticamente: #{article.id} - #{article.name}")
    end
  end
end
