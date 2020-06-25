class AddColumnsToStations < ActiveRecord::Migration[6.0]
  def change
    add_column :stations, :orderer, :integer
    add_column :stations, :parent_station_id, :integer
  end
end
