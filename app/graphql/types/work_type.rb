# frozen_string_literal: true

module Types
  class WorkType < Types::BaseObject
    field :id, ID, null: false
    field :investigation_id, Integer
    field :doi, String
    field :title, String
    field :root_work, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :citations, [Types::CitationType], null: true
    field :references, [Types::ReferenceType], null: true
  end
end
