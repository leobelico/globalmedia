module Resolvers
  module ResolversArticle
    module Fields
      class FieldSection < Resolvers::Base
        type Types::Custom::SectionType, null: true

        def resolve
          Section.find_by(id: object.articable_id)
        end
      end
    end
  end
end