class SetHighlightsJob < ApplicationJob
  queue_as :default

  def perform(article_id, section_id)
    Article.where("articable_id = ? AND id != ?", article_id, section_id).update_all(highlight: false)
  end
end
