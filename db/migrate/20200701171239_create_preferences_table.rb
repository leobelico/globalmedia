class CreatePreferencesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|
      t.string :key, default: ""
      t.string :value, default: ""
      t.timestamps
    end
  end
end
