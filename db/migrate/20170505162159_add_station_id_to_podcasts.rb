class AddStationIdToPodcasts < ActiveRecord::Migration[5.0]
  def change
    add_reference :podcasts, :station, foreign_key: true
  end
end
