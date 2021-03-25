module Types
  module Custom
    class ArticleAnalyticsType < Types::BaseObject
      field :total_views, Integer, null: false
    end
  end
end
