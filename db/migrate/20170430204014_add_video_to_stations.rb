class AddVideoToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :video, :boolean, default: false
  end
end
