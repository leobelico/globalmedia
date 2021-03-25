module Resolvers
  module ResolversLocation
    class ResolverAllLocations < Resolvers::Base
      type [Types::Custom::LocationType], null: false
      def resolve
        Location.all
      end
    end
  end
end
