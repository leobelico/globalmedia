class AddLocationIdColumnToArticlesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :location_id, :integer, :default => 0
  end
end
