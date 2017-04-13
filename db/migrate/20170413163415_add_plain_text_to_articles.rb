class AddPlainTextToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :plain_text, :string
  end
end
