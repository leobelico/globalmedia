class AddSlugColumnToHashtagsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :hashtags, :slug, :string, :default => 'default' , null: false
  end
end
