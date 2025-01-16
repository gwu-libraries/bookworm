# frozen_string_literal: true

module Types
  class WorksPrimaryLocationType < Types::BaseObject
    field :id, ID, null: false
    field :work_openalex_id, String
    field :source_openalex_id, String
    field :landing_page_url, String
    field :pdf_url, String
    field :is_oa, Boolean
    field :version, String
    field :license, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
