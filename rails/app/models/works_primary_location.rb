# frozen_string_literal: true

class WorksPrimaryLocation < ApplicationRecord
  belongs_to :work,
             primary_key: :work_openalex_id,
             foreign_key: :work_openalex_id
             
  belongs_to :source,
             primary_key: :source_openalex_id,
             foreign_key: :source_openalex_id
end
