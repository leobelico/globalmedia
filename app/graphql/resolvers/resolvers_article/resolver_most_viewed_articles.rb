module Resolvers
  module ResolversArticle
    class ResolverMostViewedArticles < Resolvers::Base
      type [Types::Custom::ArticleType], null: false

      argument :limit, Integer, required: false
      argument :from, String, required: true
      argument :to, String, required: true

      def resolve(limit: 10, from: nil , to: nil)
        Article.select('articles.*, SUM(hits.number) AS total_views_sum')
        .joins('INNER JOIN hits ON articles.id = hits.article_id')
        .where('articles.created_at BETWEEN ? AND ?', from, to)
        .group('articles.id')
        .order('total_views_sum DESC')
        .limit(limit)
      end
    end
  end
end
