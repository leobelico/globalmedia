class AddSlugToKeywords < ActiveRecord::Migration[5.0]
  def change
    add_column :keywords, :slug, :string, default: ""
  end
end
