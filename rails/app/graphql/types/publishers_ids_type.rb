# frozen_string_literal: true

module Types
  class PublishersIdsType < Types::BaseObject
    field :id, ID, null: false
    field :publisher_openalex_id, String
    field :ror, String
    field :wikidata, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
