module Resolvers
  module ResolversSection
    class ResolverAllSections < Resolvers::Base
      type [Types::Custom::SectionType], null: false
      def resolve
        Section.all
      end
    end
  end
end
