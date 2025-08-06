class ScheduledPublishingJob < ApplicationJob
  queue_as :default

  def perform
    articles_to_publish = Article.where(published: false, draft: 1)
                                .where("scheduled_time <= ?", Time.current)
                                .where("scheduled_time > ?", 5.minutes.ago) # Solo artículos recientemente programados
    
    return if articles_to_publish.empty? # Salir silenciosamente si no hay nada que publicar

    ActiveRecord::Base.transaction do
      articles_to_publish.update_all(
        published: true, 
        published_at: Time.current, 
        draft: 2,
        updated_at: Time.current
      )
    end

    # Log mínimo solo cuando hay cambios
    Rails.logger.info("[ScheduledPublishing] Published #{articles_to_publish.count} articles") if articles_to_publish.any?
  end
end