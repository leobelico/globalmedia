class AddArticleExclusiveToCoverArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :cover_articles, :article_exclusive, :boolean, default: false
  end
end
