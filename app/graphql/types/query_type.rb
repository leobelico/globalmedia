module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :highlightedArticles, resolver: Resolvers::ResolversArticle::ResolverHighlightedArticles, description: "Highlighted articles"
    field :latestArticles, resolver: Resolvers::ResolversArticle::ResolverLatestArticles, description: "Latest published articles"
    field :mostViewedArticles, resolver: Resolvers::ResolversArticle::ResolverMostViewedArticles, description: "Most viewed articles"
    field :mostViewedArticlesBySection, resolver: Resolvers::ResolversArticle::ResolverMostViewedArticlesBySection, description: "Most viewed articles by section"

    field :sections, resolver: Resolvers::ResolversSection::ResolverAllSections, description: "All sections"
    field :section, resolver: Resolvers::ResolversSection::ResolverFindSection, description: "Find section"

    field :currentStationsOnAir, resolver: Resolvers::ResolversStation::ResolverCurrentStationsOnAirStations, description: "Current stations on air"

    field :preferences, resolver: Resolvers::ResolversPreference::ResolverAllPreferences, description: "All preferences"

    field :mostViewedAuthors, resolver: Resolvers::ResolversAuthor::ResolverMostViewedAuthors, description: "Most viewed authors"

    field :locations, resolver: Resolvers::ResolversLocation::ResolverAllLocations, description: "All locations"

    field :currentHighlightsByLocation, resolver: Resolvers::ResolversHighlight::ResolverCurrentHighlightsByLocation, description: "Current highlights by location"

  end
end
