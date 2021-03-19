module Resolvers
  module ResolversPreference
    class ResolverAllPreferences < Resolvers::Base
      type [Types::Custom::PreferenceType], null: false
      def resolve
        Preference.all
      end
    end
  end
end
