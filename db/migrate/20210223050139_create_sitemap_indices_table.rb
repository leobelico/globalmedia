class CreateSitemapIndicesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sitemap_indices do |t|
      t.datetime :lastmod, :null => false
      t.integer :total_records, default: 0, :null => false
      t.timestamps
    end
  end
end
