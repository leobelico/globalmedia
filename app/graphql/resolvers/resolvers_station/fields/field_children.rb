module Resolvers
  module ResolversStation
    module Fields
      class FieldChildren < Resolvers::Base
        type [Types::Custom::StationType], null: false
        def resolve
          Station.where('parent_station_id = ?', object.id)
        end
      end
    end
  end
end
