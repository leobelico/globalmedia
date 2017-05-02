class AddSelectedToHashtags < ActiveRecord::Migration[5.0]
  def change
    add_column :hashtags, :selected, :boolean, default: false
  end
end
