class AddBroadcasterImageToTimetables < ActiveRecord::Migration[5.0]
  def change
    add_column :timetables, :broadcaster_image, :string
  end
end
