module Resolvers
  module ResolversAuthor
    class ResolverMostViewedAuthors < Resolvers::Base
      type [Types::Custom::AuthorType], null: false

      argument :limit, Integer, required: false
      argument :from, String, required: true
      argument :to, String, required: true

      def resolve(limit: 10, from: nil , to: nil)
        Author.select('authors.*, SUM(hits.number) AS total_views_sum')
        .joins('INNER JOIN articles ON authors.id = articles.author_id')
        .joins('INNER JOIN hits ON articles.id = hits.article_id')
        .where('articles.created_at BETWEEN ? AND ?', from, to)
        .group('authors.id, articles.author_id')
        .order('total_views_sum DESC')
        .limit(limit)
      end
    end
  end
end
