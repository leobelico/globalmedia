class AddSectionSlugToCoverArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :cover_articles, :section_slug, :string
    add_column :cover_articles, :section_name, :string
    add_column :cover_articles, :section_description, :string
    add_column :cover_articles, :section_color, :string
  end
end
