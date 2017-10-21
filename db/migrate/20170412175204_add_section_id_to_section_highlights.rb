class AddSectionIdToSectionHighlights < ActiveRecord::Migration[5.0]
  def change
    add_reference :section_highlights, :section, foreign_key: true
  end
end
