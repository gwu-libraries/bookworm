class WorksAuthorship < ApplicationRecord
  belongs_to :author,
             primary_key: :author_openalex_id,
             foreign_key: :author_openalex_id
  belongs_to :work,
             primary_key: :work_openalex_id,
             foreign_key: :work_openalex_id
  belongs_to :institution,
             primary_key: :institution_openalex_id,
             foreign_key: :institution_openalex_id
end
