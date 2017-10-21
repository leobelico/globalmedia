class CreateGlobalRecommendationArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :global_recommendation_articles do |t|
      t.string :name, default: ""
      t.string :article_slug, default: ""
      t.string :article_image, default: ""
      t.integer :section_id
      t.boolean :global_recommendation, default: false

      t.timestamps
    end
  end
end
