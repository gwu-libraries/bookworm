# frozen_string_literal: true

module Types
  class InstitutionsIdsType < Types::BaseObject
    field :id, ID, null: false
    field :institution_openalex_id, String
    field :ror, String
    field :grid, String
    field :wikipedia, String
    field :wikidata, String
    field :mag, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
