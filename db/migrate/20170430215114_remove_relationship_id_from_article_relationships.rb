class RemoveRelationshipIdFromArticleRelationships < ActiveRecord::Migration[5.0]
  def change
    remove_column :article_relationships, :relationship_id, :integer
  end
end
