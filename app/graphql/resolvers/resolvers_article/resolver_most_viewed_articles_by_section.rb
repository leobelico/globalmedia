module Resolvers
  module ResolversArticle
    class ResolverMostViewedArticlesBySection < Resolvers::Base
      type [Types::Custom::ArticleType], null: false

      argument :section_id, Integer, required: true
      argument :limit, Integer, required: false
      argument :from, String, required: true
      argument :to, String, required: true

      def resolve(section_id: 0, limit: 10, from: nil , to: nil)
        Article.select('articles.*, SUM(hits.number) AS total_views_sum')
               .joins('INNER JOIN hits ON articles.id = hits.article_id')
               .where('articles.articable_id = ? AND articles.created_at BETWEEN ? AND ?', section_id, from, to)
               .group('articles.id')
               .order('total_views_sum DESC')
               .limit(limit)
      end
    end
  end
end

