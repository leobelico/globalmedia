class CreatePodcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :podcasts do |t|
      t.string :name, default: ""
      t.string :stream_url, default: ""

      t.timestamps
    end
  end
end
