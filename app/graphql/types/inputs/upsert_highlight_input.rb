module Types
  module Inputs
    class UpsertHighlightInput < Types::BaseInputObject
      argument :order, Integer, required: true
      argument :article_id, Integer, required: true
      argument :location_id, Integer, required: true
      argument :scheduled_time, String, required: true
      argument :published, Boolean, required: false, default_value: false
    end
  end
end