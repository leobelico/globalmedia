class CreateCoverArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :cover_articles do |t|
      t.string :name
      t.string :article_slug
      t.string :article_image
      t.string :section_id
      t.string :article_highlight

      t.timestamps
    end
  end
end
