module Resolvers
  module ResolversSection
    module Fields
      class FieldArticles < Resolvers::Base
        type [Types::Custom::ArticleType], null: true

        argument :skip, Integer, required: false
        argument :limit, Integer, required: false

        def resolve(skip: 0, limit: 10)
          Article.where('articable_id = ?', object.id).order('id DESC').offset(skip).limit(limit)
        end
      end
    end
  end
end

