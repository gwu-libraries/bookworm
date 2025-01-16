# frozen_string_literal: true

module Types
  class AuthorsIdsType < Types::BaseObject
    field :id, ID, null: false
    field :author_openalex_id, String
    field :orcid, String
    field :scopus, String
    field :twitter, String
    field :wikipedia, String
    field :mag, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
