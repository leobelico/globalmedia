class AddSlugToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :slug, :string, default: ""
  end
end
