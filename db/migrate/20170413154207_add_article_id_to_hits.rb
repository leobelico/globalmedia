class AddArticleIdToHits < ActiveRecord::Migration[5.0]
  def change
    add_reference :hits, :article, foreign_key: true
  end
end
