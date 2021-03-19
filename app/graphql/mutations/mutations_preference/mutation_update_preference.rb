module Mutations
  module MutationsPreference
    class MutationUpdatePreference < Resolvers::Base
      type Types::Custom::PreferenceType, null: true
      argument :id, Integer, required: true
      argument :input, Types::Inputs::UpsertPreferenceInput, required: true

      def resolve(id: nil , input: {})
        result = Preference.find_by(id: id)
        if result != nil
          result.update(input.to_hash)
        end
        result
      end
    end
  end
end