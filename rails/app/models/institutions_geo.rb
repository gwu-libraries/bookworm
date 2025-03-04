# frozen_string_literal: true

class InstitutionsGeo < ApplicationRecord
  belongs_to :institution,
             primary_key: :institution_openalex_id,
             foreign_key: :institution_openalex_id
end
