# frozen_string_literal: true

module Types
  class InstitutionType < Types::BaseObject
    field :id, ID, null: false
    field :institution_openalex_id, String
    field :ror, String
    field :display_name, String
    field :country_code, String
    field :institution_type, String
    field :homepage_url, String
    field :image_url, String
    field :image_thumbnail_url, String
    field :display_name_acronyms, GraphQL::Types::JSON
    field :display_name_alternatives, GraphQL::Types::JSON
    field :works_count, Integer
    field :cited_by_count, Integer
    field :works_api_url, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :authors, [Types::AuthorType]

    def authors
      object.authors
    end
  end
end
