class CreateHitObjectives < ActiveRecord::Migration[5.0]
  def change
    create_table :hit_objectives do |t|
      t.integer :objective, default: 0

      t.timestamps
    end
  end
end
