module Mutations
  module MutationsHighlight
    class MutationCreateHighlight < Resolvers::Base
      type Types::Custom::HighlightType, null: true
      argument :input, Types::Inputs::UpsertHighlightInput, required: true

      def resolve(input: {})
        scheduled = input.scheduled_time.to_datetime
        now = DateTime.now
        result = Highlight.create(input.to_hash)
        if scheduled <= now
          result.update(published: true)
        end
        result
      end
    end
  end
end