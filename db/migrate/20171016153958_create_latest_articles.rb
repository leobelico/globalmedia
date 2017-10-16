class CreateLatestArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :latest_articles do |t|
      t.string :name, default: ""
      t.string :article_slug, default: ""
      t.string :section_name, default: ""
      t.string :section_slug, default: ""
      t.integer :article_id
      t.datetime :published_at

      t.timestamps
    end
  end
end
