class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :name, :stream_url
  belongs_to :station, each_serializer: StationSerializer
end
