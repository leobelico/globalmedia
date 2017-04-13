class CreateSectionHighlights < ActiveRecord::Migration[5.0]
  def change
    create_table :section_highlights do |t|

      t.timestamps
    end
  end
end
