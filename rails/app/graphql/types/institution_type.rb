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
      object.authors.uniq
    end

    field :wikidata, String
    def wikidata
      object.institutions_ids.wikidata
    end

    field :wikipedia, String
    def wikipedia
      object.institutions_ids.wikipedia
    end

    field :mag, String
    def mag
      object.institutions_ids.mag
    end

    field :grid, String
    def grid
      object.institutions_ids.grid
    end

    field :city, String
    def city
      object.institutions_geo.city
    end

    field :region, String
    def region
      object.institutions_geo.region
    end

    field :country, String
    def country
      object.institutions_geo.country
    end

    field :latitude, Float
    def latitude
      object.institutions_geo.latitude
    end

    field :longitude, Float
    def longitude
      object.institutions_geo.longitude
    end
  end
end
