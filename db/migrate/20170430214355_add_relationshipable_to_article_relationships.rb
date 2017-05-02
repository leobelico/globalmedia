class AddRelationshipableToArticleRelationships < ActiveRecord::Migration[5.0]
  def change
    add_reference :article_relationships, :articable, polymorphic: true, index: true
  end
end
