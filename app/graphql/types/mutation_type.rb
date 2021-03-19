module Types
  class MutationType < Types::BaseObject
    field :createPreference, resolver: Mutations::MutationsPreference::MutationCreatePreference, description: "Create preference"
    field :updatePreference, resolver: Mutations::MutationsPreference::MutationUpdatePreference, description: "Update preference"
    field :deletePreference, resolver: Mutations::MutationsPreference::MutationDeletePreference, description: "Delete preference"
  end
end
