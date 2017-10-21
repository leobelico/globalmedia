class AddVideoUrlToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :video_url, :string, default: ""
  end
end
