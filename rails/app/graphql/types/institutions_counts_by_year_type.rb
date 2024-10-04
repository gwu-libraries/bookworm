# frozen_string_literal: true

module Types
  class InstitutionsCountsByYearType < Types::BaseObject
    field :id, ID, null: false
    field :year, Integer
    field :works_count, Integer
    field :cited_by_count, Integer
    field :oa_works_count, Integer

    field :institution, Types::InstitutionType

    def institution
      object.institution
    end
  end
end
