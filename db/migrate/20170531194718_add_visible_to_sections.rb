class AddVisibleToSections < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :visible, :boolean, default: false
  end
end
