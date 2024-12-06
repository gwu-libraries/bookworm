# frozen_string_literal: true

module Types
  class WorksOpenAccessType < Types::BaseObject
    field :id, ID, null: false
    field :work_openalex_id, String
    field :is_oa, Boolean
    field :oa_status, String
    field :oa_url, String
    field :any_repository_has_fulltext, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
