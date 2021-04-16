module Mutations
  module MutationsHighlight
    class MutationUpdateHighlight < Resolvers::Base
      type Types::Custom::HighlightType, null: true
      argument :id, Integer, required: true
      argument :input, Types::Inputs::UpsertHighlightInput, required: true

      def resolve(id: nil , input: {})
        result = Highlight.find_by(id: id)
        if result != nil
          scheduled = input.scheduled_time.to_datetime
          input_hash = input.to_hash
          now = DateTime.now
          if input_hash[:published] == true
            input_hash[:scheduled_time] = now
          end
          if scheduled <= now
            input_hash[:scheduled_time] = now
            input_hash[:published] = true
          end
          if input_hash[:published] == true
            prev_published_highlight = Highlight.where('location_id = ? AND highlights.order = ? AND published = ? AND id != ?', input_hash[:location_id], input_hash[:order], true, result.id).first
            if prev_published_highlight != nil
              result.delete
              prev_published_highlight.update(input_hash)
              result = prev_published_highlight
            else
              result.update(input_hash)
            end
          else
            result.update(input_hash)
          end
        end
        result
      end
    end
  end
end