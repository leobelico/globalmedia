class AddHighlightToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :highlight, :boolean, default: false
  end
end
