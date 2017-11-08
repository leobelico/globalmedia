class AddAppUrlToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :app_url, :string, default: ""
  end
end
