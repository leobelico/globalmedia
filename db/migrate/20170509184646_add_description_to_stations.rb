class AddDescriptionToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :description, :text, default: ""
  end
end
