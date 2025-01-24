# frozen_string_literal: true

module Types
  class SourceType < Types::BaseObject
    field :id, ID, null: false
    field :source_openalex_id, String
    field :issn_l, String
    field :issn, GraphQL::Types::JSON
    field :display_name, String
    field :publisher, String
    field :works_count, Integer
    field :cited_by_count, Integer
    field :is_oa, Boolean
    field :is_in_doaj, Boolean
    field :homepage_url, String
    field :works_api_url, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :issn_l, String
    def issn_l
      object.source_ids.issn_l
    end

    field :issn, String
    def issn
      object.sources_ids.issn
    end

    field :mag, String
    def mag
      object.sources_ids.mag
    end

    field :wikidata, String
    def wikidata
      object.sources_ids.wikidata
    end

    field :fatcat, String
    def fatcat
      object.sources_ids.fatcat
    end
  end
end
