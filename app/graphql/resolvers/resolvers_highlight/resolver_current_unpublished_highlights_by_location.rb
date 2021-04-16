module Resolvers
  module ResolversHighlight
    class ResolverCurrentUnpublishedHighlightsByLocation < Resolvers::Base
      type [Types::Custom::HighlightType], null: false

      argument :location_id, Integer, required: true

      def resolve(location_id: 0, published: false)
        Highlight.where('highlights.order < 7 AND location_id = ? AND published = ? AND scheduled_time > ?', location_id, false, (DateTime.now - 20.minute)).order('scheduled_time DESC, highlights.order ASC')
      end
    end
  end
end
