module Resolvers
  module ResolversStation
    class ResolverCurrentStationsOnAirStations < Resolvers::Base
      type [Types::Custom::StationType], null: false
      def resolve
        result = []
        time = Time.now
        day = nil

        if time.sunday?
          day = 'sunday'
        end
        if time.monday?
          day = 'monday'
        end
        if time.tuesday?
          day = 'tuesday'
        end
        if time.wednesday?
          day = 'wednesday'
        end
        if time.thursday?
          day = 'thursday'
        end
        if time.friday?
          day = 'friday'
        end
        if time.saturday?
          day = 'saturday'
        end
        if day != nil
          result = Station.distinct.joins('INNER JOIN timetables ON stations.id = timetables.station_id')
                          .where("timetables.#{day} = 'true' AND timetables.streaming_hour < '#{time}' AND stations.parent_station_id IS NULL AND timetables.end_streaming_hour > '#{time}'").order("stations.frequency asc")
                          .first(7)
        end
        result
      end
    end
  end
end
