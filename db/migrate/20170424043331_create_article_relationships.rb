class CreateArticleRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :article_relationships do |t|

      t.timestamps
    end
  end
end
