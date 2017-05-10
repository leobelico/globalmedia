class AddImagePreviewToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :image_preview, :string, default: ""
  end
end
