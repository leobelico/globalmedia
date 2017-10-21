class AddFieldsToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :image_thumbnail, :string
    add_column :articles, :image, :string
  end
end
