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
    field :display_name_acronyms, String
    field :display_name_alternatives, String
    field :works_count, Integer
    field :cited_by_count, Integer
    field :works_api_url, String

    field :institutions_ids, Types::InstitutionsIdsType
    field :institutions_geo, Types::InstitutionsGeoType
    field :institutions_counts_by_year, [Types::InstitutionsCountsByYearType]
    field :associated_institutions, [Types::InstitutionType]

    def institutions_ids
      object.institutions_ids
    end

    def institutions_geo
      object.institutions_geo
    end

    def institutions_counts_by_year
      object.institutions_counts_by_year
    end

    def associated_institutions
      object.associated_institutions
    end
  end
end
