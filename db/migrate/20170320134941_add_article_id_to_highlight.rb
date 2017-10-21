class AddArticleIdToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_reference :highlights, :article, foreign_key: true
  end
end
