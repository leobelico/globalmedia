module Resolvers
  module ResolversArticle
    module Fields
      class FieldAuthor < Resolvers::Base
        type Types::Custom::AuthorType, null: true

        def resolve
          Author.find_by(id: object.author_id)
        end
      end
    end
  end
end
