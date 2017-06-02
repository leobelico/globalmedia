class AddScheduledTimeToHighlights < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :scheduled_time, :datetime
  end
end
