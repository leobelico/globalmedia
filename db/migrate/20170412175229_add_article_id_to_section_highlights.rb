class AddArticleIdToSectionHighlights < ActiveRecord::Migration[5.0]
  def change
    add_reference :section_highlights, :article, foreign_key: true
  end
end
