class AddSecondsPlayedColumnToPodcastsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :podcasts, :seconds_played, :integer
  end
end
