class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.string :name, default: ""
      t.string :stream_url, default: ""
      t.string :image, default: ""

      t.timestamps
    end
  end
end
