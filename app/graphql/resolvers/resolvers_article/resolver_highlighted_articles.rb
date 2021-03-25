module Resolvers
  module ResolversArticle
    class ResolverHighlightedArticles < Resolvers::Base
      type [Types::Custom::ArticleType], null: false

      argument :limit, Integer, required: false

      def resolve(limit: 10)
        Article.joins('INNER JOIN highlights ON articles.id = highlights.article_id')
               .where("highlights.published = ? AND highlights.order < 7", true)
               .order(order: "ASC")
               .limit(limit)
      end
    end
  end
end