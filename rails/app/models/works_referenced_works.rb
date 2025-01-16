# frozen_string_literal: true

class WorksReferencedWorks < ApplicationRecord
  belongs_to :referencing_work,
             primary_key: :work_openalex_id,
             foreign_key: :work_openalex_id,
             class_name: 'Work'

  belongs_to :referenced_work,
             primary_key: :work_openalex_id,
             foreign_key: :referenced_work_openalex_id,
             class_name: 'Work'
end
