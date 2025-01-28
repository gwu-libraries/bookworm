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

    field :datasets, [Types::WorkType]
    def datasets
      object.works.where(work_type: "dataset")
    end

    field :articles, [Types::WorkType]
    def articles
      object.works.where(work_type: "article")
    end

    field :scopus, String
    def scopus
      object.authors_ids.scopus
    end

    field :wikipedia, String
    def wikipedia
      object.authors_ids.wikipedia
    end

    field :mag, String
    def mag
      object.authors_ids.mag
    end

    field :institutions, [Types::InstitutionType]
    def institutions
      object.institutions.uniq # move this to the Author model probably
    end
  end
end
