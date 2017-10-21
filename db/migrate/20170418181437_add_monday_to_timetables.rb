class AddMondayToTimetables < ActiveRecord::Migration[5.0]
  def change
    add_column :timetables, :monday, :boolean, default: false
    add_column :timetables, :tuesday, :boolean, default: false
    add_column :timetables, :wednesday, :boolean, default: false
    add_column :timetables, :thursday, :boolean, default: false
    add_column :timetables, :friday, :boolean, default: false
    add_column :timetables, :saturday, :boolean, default: false
    add_column :timetables, :sunday, :boolean, default: false
  end
end
