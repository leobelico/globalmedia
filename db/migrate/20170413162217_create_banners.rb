class CreateBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :banners do |t|
      t.string :large_image, default: ""
      t.string :small_image, default: ""
      t.string :size, default: ""

      t.timestamps
    end
  end
end
