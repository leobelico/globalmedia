class AddLocationIdColumnToHighlightsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :highlights, :location_id, :integer, :default => 1 , null: false
  end
end
