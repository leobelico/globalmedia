class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name, default: ""
      t.text :note, default: ""
      t.text :short_description, default: ""
      t.integer :articable_id
      t.string  :articable_type
      t.timestamps
    end
    add_index :articles, [:articable_type, :articable_id]
  end
end
