module Resolvers
  module ResolversAuthor
    module Fields
      class FieldTotalViews < Resolvers::Base
        type Integer, null: false

        argument :from, String, required: true
        argument :to, String, required: true

        def resolve(from: nil , to: nil)
          Hit.joins('INNER JOIN articles ON hits.article_id = articles.id')
            .where('articles.author_id = ? AND articles.created_at BETWEEN ? AND ?', object.id, from, to).sum(:number)
        end
      end
    end
  end
end