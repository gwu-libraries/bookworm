# frozen_string_literal: true

class InstitutionsAssociatedInstitutions < ApplicationRecord
  belongs_to :institution,
             foreign_key: 'institution_openalex_id',
             class_name: 'Institution'
  belongs_to :associated_institution,
             foreign_key: 'associated_institution_openalex_id',
             class_name: 'Institution'
end
