class AddCoverToCamera < ActiveRecord::Migration[5.0]
  def change
    add_column :cameras, :cover, :string
  end
end
