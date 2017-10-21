class AddRelatedIdToRelatedSections < ActiveRecord::Migration[5.0]
  def change
    add_reference :related_sections, :section_reference, foreign_key:  { to_table: :sections }
  end
end
