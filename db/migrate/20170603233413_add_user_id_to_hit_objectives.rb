class AddUserIdToHitObjectives < ActiveRecord::Migration[5.0]
  def change
    add_reference :hit_objectives, :user, foreign_key: true
  end
end
