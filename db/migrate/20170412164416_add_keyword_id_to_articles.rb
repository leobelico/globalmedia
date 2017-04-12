class AddKeywordIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :keyword, foreign_key: true
  end
end
