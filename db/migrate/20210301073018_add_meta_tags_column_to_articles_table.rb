class AddMetaTagsColumnToArticlesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :meta_tags, :string, :default => ''
  end
end
