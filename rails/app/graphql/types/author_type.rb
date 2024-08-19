# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :orcid, String
    field :openalex_id, String
    field :h_index, Integer
    field :i10_index, Integer
    field :cited_by_count, Integer
    field :works_count, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
