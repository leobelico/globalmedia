class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :token
      t.string :operating_system

      t.timestamps
    end
  end
end
