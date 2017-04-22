class AddUrlToBanners < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :url, :string
  end
end
