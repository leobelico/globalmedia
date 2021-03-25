module Resolvers
  module ResolversArticle
    module Fields
      class FieldAnalytics < Resolvers::Base
        type Types::Custom::ArticleAnalyticsType, null: false

        def resolve
          total_views = Hit.where('article_id = ?', object.id).sum(:number)
          {
            'total_views' => total_views
          }
        end
      end
    end
  end
end