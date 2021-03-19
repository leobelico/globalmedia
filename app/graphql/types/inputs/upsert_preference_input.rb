module Types
  module Inputs
    class UpsertPreferenceInput < Types::BaseInputObject
      argument :key, String, required: true
      argument :value, String, required: false
    end
  end
end