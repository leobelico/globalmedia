class CreateHighlights < ActiveRecord::Migration[5.0]
  def change
    create_table :highlights do |t|
      t.integer :order, default: 0

      t.timestamps
    end
  end
end
