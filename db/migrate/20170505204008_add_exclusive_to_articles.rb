class AddExclusiveToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :exclusive, :boolean, default: false
  end
end
