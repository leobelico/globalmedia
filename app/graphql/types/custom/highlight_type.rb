module Types
  module Custom
    class HighlightType < Types::BaseObject
      field :id, Integer, null: false
      field :order, Integer, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :article_id, Integer, null: true
      field :scheduled_time, GraphQL::Types::ISO8601DateTime, null: false
      field :published, Boolean, null: true
      field :location_id, Integer, null: false

      #Custom Fields
      field :article, resolver: Resolvers::ResolversHighlight::Fields::FieldArticle, null: false
    end
  end
end
