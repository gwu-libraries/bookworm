# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :author_openalex_id, String
    field :orcid, String
    field :display_name, String
    field :display_name_alternatives, GraphQL::Types::JSON
    field :works_count, Integer
    field :cited_by_count, Integer
    field :last_known_institution, String
    field :works_api_url, String

    field :authors_ids, Types::AuthorsIdsType
    field :works, [Types::WorkType]

    def authors_ids
      object.authors_ids
    end
  end
end
