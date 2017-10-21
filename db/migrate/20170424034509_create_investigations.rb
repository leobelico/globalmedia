class CreateInvestigations < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.string :name, default: ""
      t.string :image, default: ""
      t.text :description, default: ""

      t.timestamps
    end
  end
end
