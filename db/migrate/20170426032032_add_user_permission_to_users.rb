class AddUserPermissionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_permission, :boolean, default: false
  end
end
