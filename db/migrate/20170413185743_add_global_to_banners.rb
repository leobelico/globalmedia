class AddGlobalToBanners < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :global, :boolean, default: false
    add_column :banners, :titlepage, :boolean, default: false
  end
end
