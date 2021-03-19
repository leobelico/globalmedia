module Mutations
  module MutationsPreference
    class MutationDeletePreference < Resolvers::Base
      type Types::Custom::PreferenceType, null: true
      argument :id, Integer, required: true

      def resolve(id: nil)
        result = Preference.find_by(id: id)
        if result != nil
          result.delete
        end
        result
      end
    end
  end
end
