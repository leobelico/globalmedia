class AddWantsKeysToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :wants_keys, :boolean, default: false
  end
end
