class AddSelectedOnToHashtags < ActiveRecord::Migration[5.0]
  def change
    add_column :hashtags, :selected_on, :datetime
  end
end
