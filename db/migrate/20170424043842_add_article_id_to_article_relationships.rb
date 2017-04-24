class AddArticleIdToArticleRelationships < ActiveRecord::Migration[5.0]
  def change
    add_reference :article_relationships, :article, foreign_key: true
  end
end
