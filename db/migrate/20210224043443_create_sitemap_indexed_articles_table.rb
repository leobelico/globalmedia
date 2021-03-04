class CreateSitemapIndexedArticlesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sitemap_indexed_articles do |t|
      t.integer :article_id, :null => false, :references => [:articles, :id]
      t.integer :sitemap_index_id, :null => false, :references => [:sitemap_indices, :id]
      t.string :loc, :null => false
      t.datetime :lastmod, :null => false
      t.string :changefreq, default: 'never', :null => false
      t.float :priority, default: 0.9, :null => false
      t.timestamps
    end
  end
end
