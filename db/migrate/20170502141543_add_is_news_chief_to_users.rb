class AddIsNewsChiefToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_news_chief, :boolean, default: false
  end
end
