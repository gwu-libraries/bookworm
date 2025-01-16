# frozen_string_literal: true

module Types
  class PublishersCountsByYearType < Types::BaseObject
    field :id, ID, null: false
    field :publisher_openalex_id, String
    field :year, Integer
    field :works_count, Integer
    field :cited_by_count, Integer
    field :oa_works_count, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
