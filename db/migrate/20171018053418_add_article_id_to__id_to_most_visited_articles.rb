class AddArticleIdToIdToMostVisitedArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :most_visited_articles, :article_id, :integer
  end
end
