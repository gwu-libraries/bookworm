# frozen_string_literal: true

class InstitutionsAssociatedInstitutions < ApplicationRecord

  validates :institution_id, presence: true
  validates :associated_institution_id, presence: true

  belongs_to :institution, foreign_key: 'institution_id', class_name: 'Institution'
  belongs_to :associated_institution, foreign_key: 'associated_institution_id', class_name: 'Institution'

end