class AddColorToSections < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :color, :string, default: "#1b2d41"
  end
end
