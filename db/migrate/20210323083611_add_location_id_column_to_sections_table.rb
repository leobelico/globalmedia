class AddLocationIdColumnToSectionsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :location_id, :integer, :default => nil , null: true
  end
end
