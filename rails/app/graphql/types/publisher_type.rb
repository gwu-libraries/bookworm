# frozen_string_literal: true

module Types
  class PublisherType < Types::BaseObject
    field :id, ID, null: false
    field :publisher_openalex_id, String
    field :display_name, String
    field :alternate_titles, GraphQL::Types::JSON
    field :country_codes, GraphQL::Types::JSON
    field :hierarchy_level, Integer
    field :parent_publisher, String
    field :works_count, Integer
    field :cited_by_count, Integer
    field :sources_api_url, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
