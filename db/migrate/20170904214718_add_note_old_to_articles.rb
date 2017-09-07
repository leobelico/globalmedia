class AddNoteOldToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :note_old, :text, default: ""
  end
end
