# frozen_string_literal: true

module Types
  class WorksAuthorshipType < Types::BaseObject
    field :id, ID, null: false
    field :work_openalex_id, String
    field :author_position, String
    field :author_openalex_id, String
    field :institution_openalex_id, String
    field :raw_affiliation_string, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
