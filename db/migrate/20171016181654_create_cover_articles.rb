class CreateCoverArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :cover_articles do |t|
      t.string :name, default: ""
      t.string :article_slug, default: ""
      t.string :article_image, default: ""
      t.integer :section_id
      t.integer :article_id
      t.boolean :article_highlight, default: false

      t.timestamps
    end
  end
end
