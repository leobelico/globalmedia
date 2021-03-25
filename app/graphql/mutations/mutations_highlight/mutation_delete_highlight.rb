module Mutations
  module MutationsHighlight
    class MutationDeleteHighlight < Resolvers::Base
      type Types::Custom::HighlightType, null: true
      argument :id, Integer, required: true

      def resolve(id: nil)
        result = Highlight.find_by(id: id)
        if result != nil
          result.delete
        end
        result
      end
    end
  end
end
