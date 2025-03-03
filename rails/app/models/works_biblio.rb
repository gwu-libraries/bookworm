class WorksBiblio < ApplicationRecord
  belongs_to :work,
             primary_key: :work_openalex_id,
             foreign_key: :work_openalex_id
end
