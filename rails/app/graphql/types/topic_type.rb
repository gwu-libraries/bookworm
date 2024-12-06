# frozen_string_literal: true

module Types
  class TopicType < Types::BaseObject
    field :id, ID, null: false
    field :topic_openalex_id, String
    field :display_name, String
    field :openalex_subfield_id, Integer
    field :openalex_subfield_display_name, String
    field :openalex_field_id, Integer
    field :openalex_field_display_name, String
    field :openalex_domain_id, Integer
    field :openalex_domain_display_name, String
    field :description, String
    field :keywords, String
    field :works_api_url, String
    field :wikipedia_id, String
    field :works_count, Integer
    field :cited_by_count, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
