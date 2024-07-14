# frozen_string_literal: true

module Types
  class WorkType < Types::BaseObject
    field :id, ID, null: false
    field :investigation_id, Integer
    field :doi, String
    field :openalex_id, String
    field :title, String
    field :is_open_access, Boolean
    field :open_access_url, String
    field :language, String
    field :publication_year, Integer
    field :keywords, [String]
    field :topics, [String]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :citations, [Types::CitationType], null: true
    field :references, [Types::ReferenceType], null: true
    field :authors, [Types::AuthorType], null: true
  end
end
