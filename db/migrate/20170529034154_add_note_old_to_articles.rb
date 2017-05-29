class AddNoteOldToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :note_old, :text
    add_column :articles, :old_id, :integer
    add_column :images, :old_id, :integer
    add_column :sections, :old_id, :integer
  end
end
