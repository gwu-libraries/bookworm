# frozen_string_literal: true

module Types
  class InstitutionsAssociatedInstitutionsType < Types::BaseObject
    field :id, ID, null: false
    field :institution_openalex_id, String
    field :associated_institution_openalex_id, String
    field :relationship, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
