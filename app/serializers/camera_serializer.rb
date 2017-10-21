class CameraSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :lat, :lng, :stream, :cover
end
