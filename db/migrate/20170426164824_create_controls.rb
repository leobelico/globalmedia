class CreateControls < ActiveRecord::Migration[5.0]
  def change
    create_table :controls do |t|
      t.datetime :init_date
      t.datetime :end_date
      t.string :client_name, default: ""
      t.string :event_name, default: ""
      t.string :event_address, default: ""
      t.string :station_name, default: ""
      t.string :unit_name, default: ""
      t.text :techs, default: ""
      t.text :observations, default: ""
      t.string :contract_number, default: ""
      t.string :contract_state, default: ""
      t.string :agent_name, default: ""
      t.boolean :datasheet, default: false

      t.timestamps
    end
  end
end
