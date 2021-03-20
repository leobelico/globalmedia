module Types
  module Custom
    class AuthorType < Types::BaseObject
      field :id, Integer, null: false
      field :name, String, null: true
      field :logo, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

      # Custom Fields
      field :totalViews, resolver: Resolvers::ResolversAuthor::Fields::FieldTotalViews, null: false
    end
  end
end
