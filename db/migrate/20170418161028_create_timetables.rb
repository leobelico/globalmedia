class CreateTimetables < ActiveRecord::Migration[5.0]
  def change
    create_table :timetables do |t|
      t.time :streaming_hour
      t.string :name, default: ""
      t.string :image, default: ""

      t.timestamps
    end
  end
end
