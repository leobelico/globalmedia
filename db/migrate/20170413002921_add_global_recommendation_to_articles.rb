class AddGlobalRecommendationToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :global_recommendation, :boolean, default: false
  end
end
