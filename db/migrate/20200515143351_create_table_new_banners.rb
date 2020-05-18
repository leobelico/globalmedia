class CreateTableNewBanners < ActiveRecord::Migration[6.0]
  def change
    create_table :new_banners do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.string :banner_type, null: false #[:interstitial, :push_down, :top_board, :layer, :push_down_mobile, :banner_mobile]
      t.text :content, null: false
      t.boolean :is_active, null: false, default: false
      t.datetime :show_at, null: false
      t.datetime :expiry_at, null: false
      t.timestamps
    end
  end
end
