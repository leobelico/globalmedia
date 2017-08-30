class AddKeyToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :key, :string, default: ""
    add_column :notifications, :key_id, :string, default: ""
  end
end
