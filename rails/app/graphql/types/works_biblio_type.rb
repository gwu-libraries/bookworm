# frozen_string_literal: true

module Types
  class WorksBiblioType < Types::BaseObject
    field :id, ID, null: false
    field :work_openalex_id, String
    field :volume, String
    field :issue, String
    field :first_page, String
    field :last_page, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
