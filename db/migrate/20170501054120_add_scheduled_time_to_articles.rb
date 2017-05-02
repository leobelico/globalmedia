class AddScheduledTimeToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :scheduled_time, :datetime
  end
end
