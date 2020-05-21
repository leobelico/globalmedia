class AddDescriptionToPodcast < ActiveRecord::Migration[6.0]
  def change
  	add_column :podcasts, :description, :string, default: ""
  end
end
