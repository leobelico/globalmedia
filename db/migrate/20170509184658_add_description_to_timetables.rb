class AddDescriptionToTimetables < ActiveRecord::Migration[5.0]
  def change
    add_column :timetables, :description, :text, default: ""
  end
end
