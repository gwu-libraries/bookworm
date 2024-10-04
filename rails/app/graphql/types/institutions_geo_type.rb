# frozen_string_literal: true

module Types
  class InstitutionsGeoType < Types::BaseObject
    field :id, ID, null: false
    field :institution_id, Integer
    field :city, String
    field :region, String
    field :country_code, String
    field :country, String
    field :latitude, Float
    field :longitude, Float

    field :institution, Types::InstitutionType

    def institution
      object.institution
    end
  end
end
