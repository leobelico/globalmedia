class AddRelationshipIdToArticleRelationships < ActiveRecord::Migration[5.0]
  def change
    add_reference :article_relationships, :relationship, foreign_key: true
  end
end
