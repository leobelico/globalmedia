module Resolvers
  module ResolversSection
    class ResolverFindSection < Resolvers::Base
      type Types::Custom::SectionType, null: true

      argument :id, ID, required: false

      def resolve(id: nil)
        Section.find_by(id: id)
      end
    end
  end
end
