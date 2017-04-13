class AddNameToBanners < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :name, :string, default: ""
  end
end
