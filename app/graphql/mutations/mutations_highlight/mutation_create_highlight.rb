module Mutations
  module MutationsHighlight
    class MutationCreateHighlight < Resolvers::Base
      type Types::Custom::HighlightType, null: true
      argument :input, Types::Inputs::UpsertHighlightInput, required: true

      def resolve(input: {})
        now = DateTime.now
        scheduled = input.scheduled_time.to_datetime
        input_hash = input.to_hash
        if input_hash[:published] == true
          input_hash[:scheduled_time] = now
        end
        if scheduled <= now
          input_hash[:scheduled_time] = now
          input_hash[:published] = true
        end
        result = nil
        if input_hash[:published] == true
          if Article.exists?(input_hash[:article_id])
            Article.find(input_hash[:article_id]).update_attribute(:published, true)
          end
          prev_published_highlight = Highlight.where('location_id = ? AND highlights.order = ? AND published = ?', input_hash[:location_id], input_hash[:order], true).first
          if prev_published_highlight != nil
            prev_published_highlight.update(input_hash)
            result = prev_published_highlight
          else
            result = Highlight.create(input_hash)
          end
        else
          result = Highlight.create(input_hash)
        end
        result
      end
    end
  end
end