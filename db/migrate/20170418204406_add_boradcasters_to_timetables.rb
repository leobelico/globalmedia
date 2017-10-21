class AddBoradcastersToTimetables < ActiveRecord::Migration[5.0]
  def change
    add_column :timetables, :broadcasters, :string
  end
end
