class CreateHits < ActiveRecord::Migration[5.0]
  def change
    create_table :hits do |t|
      t.integer :number, default: 0

      t.timestamps
    end
  end
end
