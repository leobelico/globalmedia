module Resolvers
  module ResolversHighlight
    class ResolverCurrentPublishedHighlightsByLocation < Resolvers::Base
      type [Types::Custom::HighlightType], null: false

      argument :location_id, Integer, required: true

      def resolve(location_id: 0, published: false)
        Highlight.where('highlights.order < 7 AND location_id = ? AND published = ?', location_id, true).order('scheduled_time DESC, highlights.order ASC')
      end
    end
  end
end
