class CreateLocationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :key, :null => false
      t.string :name, :null => false
      t.string :description, :null => true
      t.string :meta_description, :null => true
      t.float :latitude, default: 0, :null => false
      t.float :longitude, default: 0, :null => false
      t.timestamps
    end
  end
end
