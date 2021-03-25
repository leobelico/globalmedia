module Types
  module Custom
    class AuthorAnalyticsType < Types::BaseObject
      field :total_views, Integer, null: false
    end
  end
end
