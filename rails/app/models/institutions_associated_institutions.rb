# frozen_string_literal: true

class InstitutionsAssociatedInstitutions < ApplicationRecord
  belongs_to :associating_institution,
             primary_key: :institution_openalex_id,
             foreign_key: :institution_openalex_id,
             class_name: 'Institution'

  belongs_to :associated_institution,
             primary_key: :institution_openalex_id,
             foreign_key: :associated_institution_openalex_id,
             class_name: 'Institution'
end
