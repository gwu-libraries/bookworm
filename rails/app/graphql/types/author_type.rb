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

    field :works, [Types::WorkType]
    def works
      object.works
    end

    field :authors_ids, Types::AuthorsIdsType
    def authors_ids
      object.authors_ids
    end

    field :institutions, [Types::InstitutionType]
    def institutions
      object.institutions.uniq # move this to the Author model probably
    end

    field :authors_counts_by_year, [Types::AuthorsCountsByYearType]
    def authors_counts_by_year
      object.authors_counts_by_year
    end
  end
end
