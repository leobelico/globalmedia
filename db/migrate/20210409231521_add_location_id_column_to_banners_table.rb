class AddLocationIdColumnToBannersTable < ActiveRecord::Migration[6.0]
  def change
    add_column :banners, :location_id, :integer, :default => 1 , null: false
  end
end
