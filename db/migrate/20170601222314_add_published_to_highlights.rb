class AddPublishedToHighlights < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :published, :boolean, default: false
  end
end
