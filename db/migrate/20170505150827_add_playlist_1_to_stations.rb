class AddPlaylist1ToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :playlist_1, :string, default: ""
    add_column :stations, :playlist_2, :string, default: ""
    add_column :stations, :playlist_3, :string, default: ""
    add_column :stations, :playlist_4, :string, default: ""
  end
end
