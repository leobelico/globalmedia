class AddBannerPermissionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :banners_permission, :boolean, default: false
    add_column :users, :create_articles_permission, :boolean, default: false
    add_column :users, :video_complaints_permission, :boolean, default: false
    add_column :users, :hits_permission, :boolean, default: false
    add_column :users, :destroy_articles_permission, :boolean, default: false
    add_column :users, :radio_stations_permission, :boolean, default: false
    add_column :users, :remote_controls_permission, :boolean, default: false
  end
end
