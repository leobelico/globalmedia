module Resolvers
  module ResolversHighlight
    class ResolverCurrentHighlightsByLocation < Resolvers::Base
      type [Types::Custom::HighlightType], null: false

      argument :location_id, Integer, required: true

      def resolve(location_id: 0)
        Highlight.where('highlights.order < 7 AND location_id = ?', location_id).order('scheduled_time DESC, highlights.order ASC').limit(6)
      end
    end
  end
end
