class AddUpdatedRecommendationOnToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :updated_recommendation_on, :datetime
  end
end
