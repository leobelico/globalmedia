module Types
  module Custom
    class LocationType < Types::BaseObject
      field :id, Integer, null: false
      field :key, String, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :latitude, Float, null: false
      field :longitude, Float, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
