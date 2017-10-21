class AddFrequencyToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :frequency, :float, default: "0.0"
  end
end
