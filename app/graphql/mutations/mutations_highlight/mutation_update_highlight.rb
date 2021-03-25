module Mutations
  module MutationsHighlight
    class MutationUpdateHighlight < Resolvers::Base
      type Types::Custom::HighlightType, null: true
      argument :id, Integer, required: true
      argument :input, Types::Inputs::UpsertHighlightInput, required: true

      def resolve(id: nil , input: {})
        scheduled = input.scheduled_time.to_datetime
        now = DateTime.now
        result = Highlight.find_by(id: id)
        if result != nil
          result.update(input.to_hash)
          if scheduled <= now
            result.update(published: true)
          end
        end
        result
      end
    end
  end
end