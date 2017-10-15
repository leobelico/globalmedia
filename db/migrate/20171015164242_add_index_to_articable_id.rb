class AddIndexToArticableId < ActiveRecord::Migration[5.0]
  def change
  	add_index :articles, :articable_id

  end
end
