class CreateHashtagsArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles_hashtags do |t|
  		t.integer :hashtag_id, :article_id

      t.timestamps
    end
  end
end
