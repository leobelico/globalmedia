class CreateMostVisitedArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :most_visited_articles do |t|
      t.string :name, default: ""
      t.string :article_slug, default: ""
      t.string :article_image, default: ""

      t.timestamps
    end
  end
end
