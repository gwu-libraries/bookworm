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

  has_many :institutions_associated_institutions_connections,
           primary_key: :institution_openalex_id,
           foreign_key: :institution_openalex_id,
           class_name: 'InstitutionsAssociatedInstitutions'

  # these associated/associating connections are maybe not ideal, 
  # because you need to call either associating_institutions OR associated_institutions
  # should be interchangable (maybe?)

  has_many :associated_institutions,
           through: :institutions_associated_institutions_connections,
           source: :associated_institution

  has_many :institutions_associating_institutions_connections,
           primary_key: :institution_openalex_id,
           foreign_key: :associated_institution_openalex_id,
           class_name: 'InstitutionsAssociatedInstitutions'

  has_many :associating_institutions,
           through: :institutions_associating_institutions_connections,
           source: :associating_institution

  has_many :works_authorships,
           primary_key: :institution_openalex_id,
           foreign_key: :institution_openalex_id

  has_many :authors, through: :works_authorships
  has_many :works, through: :works_authorships
end
