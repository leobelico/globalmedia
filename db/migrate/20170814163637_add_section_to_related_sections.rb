class AddSectionToRelatedSections < ActiveRecord::Migration[5.0]
  def change
    add_reference :related_sections, :section, foreign_key: true
  end
end
