module Types
  class MutationType < Types::BaseObject
    field :createPreference, resolver: Mutations::MutationsPreference::MutationCreatePreference, description: "Create preference"
    field :updatePreference, resolver: Mutations::MutationsPreference::MutationUpdatePreference, description: "Update preference"
    field :deletePreference, resolver: Mutations::MutationsPreference::MutationDeletePreference, description: "Delete preference"

    field :createHighlight, resolver: Mutations::MutationsHighlight::MutationCreateHighlight, description: "Create highlight"
    field :updateHighlight, resolver: Mutations::MutationsHighlight::MutationUpdateHighlight, description: "Update highlight"
    field :deleteHighlight, resolver: Mutations::MutationsHighlight::MutationDeleteHighlight, description: "Delete highlight"
  end
end
