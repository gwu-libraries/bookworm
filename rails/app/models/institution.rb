# frozen_string_literal: true

class Institution < ApplicationRecord
  has_many :institutions_counts_by_year,
          primary_key: :institution_openalex_id,
          foreign_key: :institution_openalex_id

  has_one :institutions_geo,
          primary_key: :institution_openalex_id,
          foreign_key: :institution_openalex_id

  has_one :institutions_ids,
          primary_key: :institution_openalex_id,
          foreign_key: :institution_openalex_id

  has_many :institutions_associated_institutions,
           foreign_key: :associated_institution_openalex_id,
           class_name: 'InstitutionsAssociatedInstitutions'

  has_many :associated_institutions,
           through: :institutions_associated_institutions,
           source: :institution

  has_many :works_authorships,
           primary_key: :institution_openalex_id,
           foreign_key: :institution_openalex_id

  has_many :authors, through: :works_authorships
end
