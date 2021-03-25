module Resolvers
  module ResolversHighlight
    module Fields
      class FieldArticle < Resolvers::Base
        type Types::Custom::ArticleType, null: false

        def resolve
          Article.find_by(id: object.article_id)
        end
      end
    end
  end
end