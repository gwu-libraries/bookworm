# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :orcid, String
    field :openalex_id, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
