class AddArticleIdToImages < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :article, foreign_key: true
  end
end
