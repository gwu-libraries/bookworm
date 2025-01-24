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

    field :referenced_articles, [Types::WorkType]
    def referenced_articles
      object.referenced_works.where(work_type: "article")
    end

    field :referencing_works, [Types::WorkType]
    def referencing_works
      object.referencing_works
    end

    field :referencing_articles, [Types::WorkType]
    def referencing_articles
      object.referencing_articles.where(work_type: "article")
    end

    field :topics, [Types::TopicType]
    def topics
      object.topics
    end

    field :is_oa, Boolean
    def is_oa
      object.works_open_access.is_oa
    end

    field :oa_status, String
    def oa_status
      object.works_open_access.oa_status
    end

    field :oa_url, String
    def oa_url
      object.works_open_access.oa_url
    end

    field :volume, String
    def volume
      object.works_biblio.volume
    end 

    field :issue, String
    def issue
      object.works_biblio.issue
    end

    field :first_page, String
    def first_page
      object.works_biblio.first_page
    end

    field :last_page, String
    def last_page
      object.works_biblio.last_page
    end

    field :pmid, String
    def pmid
      object.works_ids.pmid
    end

    field :pmcid, String
    def pmcid
      object.works_ids.pmcid
    end

    field :landing_page_url, String
    def landing_page_url
      object.works_best_oa_location.landing_page_url
    end

    field :pdf_url, String
    def pdf_url
      object.works_best_oa_location.pdf_url
    end

    field :license, String
    def license
      object.works_best_oa_location.license
    end

    field :version, String
    def version
      object.works_best_oa_location.version
    end

    field :any_repository_has_fulltext, Boolean
    def any_repository_has_fulltext
      object.works_open_access.any_repository_has_fulltext
    end
  end
end
