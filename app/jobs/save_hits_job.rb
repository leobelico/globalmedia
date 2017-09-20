class SaveHitsJob < ApplicationJob
  queue_as :default

  def perform(article)
    # Do something later
    p "ARTICLE LALALA SAVE HITS" + article.name

	last_hit = Hit.where(article: article, created_at: 2.hours.ago..Time.now).last

	if last_hit
		last_hit.update_attributes(number: last_hit.number + 1)
    p "ARTICLE LALALA SAVE HITS number" + last_hit.number.to_s

	else
				#no hay ningún hit entonces lo creamos
		Hit.create(number: 1, article: article)

    p "ARTICLE LALALA SAVE HITS number" 

	end
  end
end
