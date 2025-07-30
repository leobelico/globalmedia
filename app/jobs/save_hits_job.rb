class SaveHitsJob < ApplicationJob
  queue_as :default

  def perform(article)
    last_hit = Hit.where(article: article, created_at: 2.hours.ago..Time.now).last

    if last_hit
      last_hit.update(number: last_hit.number + 1)
    else
      # No hay ningún hit, entonces lo creamos
      Hit.create(number: 1, article: article)
    end
  end
end
