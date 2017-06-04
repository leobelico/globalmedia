class AddAuthorIdToHitObjectives < ActiveRecord::Migration[5.0]
  def change
    add_reference :hit_objectives, :author, foreign_key: true
  end
end
