# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :openalex_id, String
    field :orcid, String
    field :display_name, String
    field :display_name_alternatives, String
    field :works_count, Integer
    field :cited_by_count, Integer
    field :last_known_institution, String
    field :works_api_url, String

    field :authors_ids, Types::AuthorsIdsType
    field :authors_counts_by_year, [Types::AuthorsCountsByYearType]

    def authors_ids
      object.authors_ids
    end

    def authors_counts_by_year
      object.authors_counts_by_year
    end
  end
end
