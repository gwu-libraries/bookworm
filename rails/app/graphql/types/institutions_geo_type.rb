# frozen_string_literal: true

module Types
  class InstitutionsGeoType < Types::BaseObject
    field :id, ID, null: false
    field :institution_openalex_id, String
    field :city, String
    field :geonames_city_id, Integer
    field :region, String
    field :country_code, String
    field :country, String
    field :latitude, Float
    field :longitude, Float
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
