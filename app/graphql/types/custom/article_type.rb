module Types
  module Custom
    class ArticleType < Types::BaseObject
      field :id, Integer, null: false
      field :name, String, null: true
      field :note, String, null: true
      field :short_description, String, null: true
      field :articable_id, Integer, null: true
      field :articable_type, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :slug, String, null: true
      field :keyword_id, Integer, null: true
      field :highlight, Boolean, null: true
      field :global_recommendation, Boolean, null: true
      field :user_id, Integer, null: true
      field :plain_text, String, null: true
      field :updated_recommendation_on, GraphQL::Types::ISO8601DateTime, null: true
      field :image_thumbnail, String, null: true
      field :image, String, null: true
      field :draft, Integer, null: true
      field :published, Boolean, null: true
      field :scheduled_time, GraphQL::Types::ISO8601DateTime, null: true
      field :video_url, String, null: true
      field :author_id, Integer, null: true
      field :exclusive, Boolean, null: true
      field :_extra_props, String, null: true
      field :breaking_news, Boolean, null: true
      field :note_old, String, null: true
      field :published_at, GraphQL::Types::ISO8601DateTime, null: true
      field :meta_tags, String, null: true

      # Custom Fields
      field :analytics, resolver: Resolvers::ResolversArticle::Fields::FieldAnalytics, null: false
      field :author, resolver: Resolvers::ResolversArticle::Fields::FieldAuthor, null: true
      field :section, resolver: Resolvers::ResolversArticle::Fields::FieldSection, null: false
    end
  end
end
