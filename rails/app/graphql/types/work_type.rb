# frozen_string_literal: true

module Types
  class WorkType < Types::BaseObject
    field :id, ID, null: false
    field :doi, String
    field :title, String
    field :openalex_id, String
    field :language, String
    field :publication_year, String
    field :keywords, [String]
    field :topics, [String]
    field :is_open_access, Boolean
    field :open_access_url, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :authors, [Types::AuthorType]
    field :citations, [Types::WorkType]
    field :references, [Types::WorkType]

    def authors
      object.authors
    end

    def citations
      object.citations
    end

    def references
      object.references
    end
  end
end
