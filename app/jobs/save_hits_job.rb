class SaveHitsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

	last_hit = Hit.where(article: article, created_at: 2.hours.ago..Time.now).last

	if last_hit
		last_hit.update_attributes(number: last_hit.number + 1)
	else
				#no hay ningún hit entonces lo creamos
		Hit.create(number: 1, article: article)

	end
  end
end
