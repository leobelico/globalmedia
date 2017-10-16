class AddArticleIdToGlobalRecommendationArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :global_recommendation_articles, :article_id, :integer
  end
end
