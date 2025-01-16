# frozen_string_literal: true

module Types
  class WorkType < Types::BaseObject
    field :id, ID, null: false
    field :work_openalex_id, String
    field :doi, String
    field :title, String
    field :display_name, String
    field :publication_year, Integer
    field :publication_date, String
    field :work_type, String
    field :cited_by_count, Integer
    field :is_retracted, Boolean
    field :is_paratext, Boolean
    field :cited_by_api_url, String
    field :abstract_inverted_index, GraphQL::Types::JSON
    field :language, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :authors, [Types::AuthorType]
    def authors
      object.authors
    end

    field :institutions, [Types::InstitutionType]
    def institutions
      object.institutions
    end

    field :referenced_works, [Types::WorkType]
    def referenced_works
      object.referenced_works
    end

    field :referencing_works, [Types::WorkType]
    def referencing_works
      object.referencing_works
    end

    field :works_open_access, Types::WorksOpenAccessType
    def works_open_access
      object.works_open_access
    end

    field :works_biblio, Types::WorksBiblioType
    def works_biblio
      object.works_biblio
    end

    field :topics, [Types::TopicType]
    def topics
      object.topics
    end

    field :works_ids, Types::WorksIdsType
    def works_ids
      object.works_ids
    end
  end
end
