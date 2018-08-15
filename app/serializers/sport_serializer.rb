class SportSerializer < ActiveModel::Serializer
  attributes :id, :team_one, :team_two, :team_one_image, :team_two_image, :team_one_score, :team_two_score, :team_one_goal_scorers, :team_two_goal_scorers
  
  # has_many :articles, each_serializer: ArticleSerializer 
end
