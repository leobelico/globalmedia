class AddBreakingNewsToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :breaking_news, :boolean
  end
end
