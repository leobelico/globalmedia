module Types
  module Custom
    class SectionType < Types::BaseObject
      field :id, Integer, null: false
      field :name, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :slug, String, null: true
      field :color, String, null: true
      field :order, Integer, null: true
      field :_extra_props, String, null: true
      field :visible, Boolean, null: true
      field :description, String, null: true
      field :facebook, String, null: true
      field :twitter, String, null: true

      # Custom Fields
      field :articles, resolver: Resolvers::ResolversSection::Fields::FieldArticles, null: false
    end
  end
end
