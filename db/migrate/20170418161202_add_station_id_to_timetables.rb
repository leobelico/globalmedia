class AddStationIdToTimetables < ActiveRecord::Migration[5.0]
  def change
    add_reference :timetables, :station, foreign_key: true
  end
end
