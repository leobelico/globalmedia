class AddClientToBanners < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :client, :string
  end
end
