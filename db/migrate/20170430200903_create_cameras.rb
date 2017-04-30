class CreateCameras < ActiveRecord::Migration[5.0]
  def change
    create_table :cameras do |t|
      t.string :name
      t.string :location
      t.string :lat
      t.string :lng
      t.string :stream

      t.timestamps
    end
  end
end
