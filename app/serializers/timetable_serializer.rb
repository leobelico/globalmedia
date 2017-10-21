class TimetableSerializer < ActiveModel::Serializer
  attributes :id, :name, :streaming_hour, :end_streaming_hour, :image, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :broadcasters, :broadcaster_image, :description
  belongs_to :station, each_serializer: StationSerializer
end
