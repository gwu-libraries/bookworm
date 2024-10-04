# frozen_string_literal: true

module Types
  class InstitutionsIdsType < Types::BaseObject
    field :id, ID, null: false
    field :institution_id, Integer
    field :openalex, String
    field :ror, String
    field :grid, String
    field :wikipedia, String
    field :wikidata, String
    field :mag, Integer

    field :institution, Types::InstitutionType

    def institution
      object.institution
    end
  end
end
