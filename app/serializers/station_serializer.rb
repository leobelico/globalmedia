class StationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :stream_url, :image, :frequency, :image_preview, :twitter, :facebook, :video, :news, :playlist_1, :playlist_1_image, :playlist_2, :playlist_2_image, :playlist_3, :playlist_3_image, :playlist_4, :playlist_4_image, :app_url
  has_many :timetables, serializer: TimetableSerializer
end
