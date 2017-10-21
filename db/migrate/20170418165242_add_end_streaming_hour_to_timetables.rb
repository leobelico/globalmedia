class AddEndStreamingHourToTimetables < ActiveRecord::Migration[5.0]
  def change
    add_column :timetables, :end_streaming_hour, :time
  end
end
