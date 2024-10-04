# frozen_string_literal: true

class Institution < ApplicationRecord
  has_many :institutions_counts_by_year
  has_one :institutions_geo
  has_one :institutions_ids

  has_many :institutions_associated_institutions,
           foreign_key: :associated_institution_id,
           class_name: 'InstitutionsAssociatedInstitutions'

  has_many :associated_institutions,
           through: :institutions_associated_institutions,
           source: :institution
end
