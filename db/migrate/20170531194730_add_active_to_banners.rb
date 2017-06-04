class AddActiveToBanners < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :active, :boolean, default: false
  end
end
