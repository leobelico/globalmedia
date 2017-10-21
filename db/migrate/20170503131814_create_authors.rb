class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name, default: ""
      t.string :logo, default: ""

      t.timestamps
    end
  end
end
