module Mutations
  module MutationsPreference
    class MutationCreatePreference < Resolvers::Base
      type Types::Custom::PreferenceType, null: true
      argument :input, Types::Inputs::UpsertPreferenceInput, required: true

      def resolve(input: {})
        Preference.create(input.to_hash)
      end
    end
  end
end