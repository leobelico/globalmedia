class AddFriendlySlugColumnToArticlesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :friendly_slug, :string, :default => 'default' , null: false
  end
end
