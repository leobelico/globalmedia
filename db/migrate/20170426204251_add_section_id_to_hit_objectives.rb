class AddSectionIdToHitObjectives < ActiveRecord::Migration[5.0]
  def change
    add_reference :hit_objectives, :section, foreign_key: true
  end
end
