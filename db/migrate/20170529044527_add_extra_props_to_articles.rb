class AddExtraPropsToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :_extra_props, :text
    add_column :sections, :_extra_props, :text
    add_column :images, :_extra_props, :text
  end
end
