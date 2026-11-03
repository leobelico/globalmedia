class CreateShortLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :short_links do |t|
      t.string :code, limit: 6, null: false
      t.string :url, null: false
      t.integer :article_id
      t.integer :user_id
      t.integer :clicks, default: 0, null: false
      t.datetime :last_clicked_at
      t.timestamps
    end
    add_index :short_links, :code, unique: true
    add_index :short_links, :article_id
    add_index :short_links, :url
  end
end
