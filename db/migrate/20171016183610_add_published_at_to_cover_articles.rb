class AddPublishedAtToCoverArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :cover_articles, :published_at, :datetime
  end
end
