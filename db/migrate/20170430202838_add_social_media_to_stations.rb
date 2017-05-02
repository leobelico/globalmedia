class AddSocialMediaToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :twitter, :string
    add_column :stations, :facebook, :string
  end
end
