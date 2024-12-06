# frozen_string_literal: true

module Types
  class WorksIdsType < Types::BaseObject
    field :id, ID, null: false
    field :work_openalex_id, String
    field :doi, String
    field :mag, String
    field :pmid, String
    field :pmcid, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
