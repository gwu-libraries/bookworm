# frozen_string_literal: true

module Types
  class WorkType < Types::BaseObject
    field :id, ID, null: false
    field :work_openalex_id, String
    field :doi, String
    field :title, String
    field :display_name, String
    field :publication_year, Integer
    field :publication_date, String
    field :work_type, String
    field :cited_by_count, Integer
    field :is_retracted, Boolean
    field :is_paratext, Boolean
    field :cited_by_api_url, String
    field :abstract_inverted_index, GraphQL::Types::JSON
    field :language, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
