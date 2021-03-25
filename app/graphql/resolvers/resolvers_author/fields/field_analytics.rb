module Resolvers
  module ResolversAuthor
    module Fields
      class FieldAnalytics < Resolvers::Base
        type Types::Custom::AuthorAnalyticsType, null: false

        argument :from, String, required: true
        argument :to, String, required: true

        def resolve(from: nil , to: nil)
          total_views = Hit.joins('INNER JOIN articles ON hits.article_id = articles.id')
            .where('articles.author_id = ? AND articles.created_at BETWEEN ? AND ?', object.id, from, to).sum(:number)
          {
            'total_views' => total_views
          }
        end
      end
    end
  end
end