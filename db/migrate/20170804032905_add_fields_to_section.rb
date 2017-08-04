class AddFieldsToSection < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :facebook, :string
    add_column :sections, :twitter, :string
  end
end
