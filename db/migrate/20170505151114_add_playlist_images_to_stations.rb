class AddPlaylistImagesToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :playlist_1_image, :string, default: ""
    add_column :stations, :playlist_2_image, :string, default: ""
    add_column :stations, :playlist_3_image, :string, default: ""
    add_column :stations, :playlist_4_image, :string, default: ""
    add_column :stations, :news, :boolean, default: false
  end
end
