class CreateSports < ActiveRecord::Migration[5.0]
  def change
    create_table :sports do |t|
      t.string :team_one
      t.string :team_two
      t.string :team_one_image
      t.string :team_two_image
      t.string :team_one_score
      t.string :team_two_score
      t.string :team_one_goal_scorers
      t.string :team_two_goal_scorers

      t.timestamps
    end
  end
end
