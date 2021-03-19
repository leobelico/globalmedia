module Resolvers
  module ResolversArticle
    class ResolverLatestArticles < Resolvers::Base
      type [Types::Custom::ArticleType], null: false

      argument :limit, Integer, required: false

      def resolve(limit: 10)
        Article.where('published_at IS NOT NULL').order('published_at DESC').limit(limit)
      end
    end
  end
end
