module Types
  module Custom
    class StationType < Types::BaseObject
      field :id, Integer, null: false
      field :name, String, null: true
      field :stream_url, String, null: true
      field :image, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :slug, String, null: true
      field :twitter, String, null: true
      field :facebook, String, null: true
      field :video, Boolean, null: true
      field :playlist_1, String, null: true
      field :playlist_2, String, null: true
      field :playlist_3, String, null: true
      field :playlist_4, String, null: true
      field :playlist_1_image, String, null: true
      field :playlist_2_image, String, null: true
      field :playlist_3_image, String, null: true
      field :playlist_4_image, String, null: true
      field :news, Boolean, null: true
      field :frequency, Float, null: true
      field :description, String, null: true
      field :image_preview, String, null: true
      field :app_url, String, null: true
      field :orderer, Integer, null: true
      field :parent_station_id, Integer, null: true

      # Custom Fields
      field :children, resolver: Resolvers::ResolversStation::Fields::FieldChildren, null: false
    end
  end
end
