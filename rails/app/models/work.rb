# frozen_string_literal: true

class Work < ApplicationRecord
  has_many :works_authorships,
           primary_key: :work_openalex_id,
           foreign_key: :work_openalex_id

  has_many :authors, through: :works_authorships
  has_many :institutions, through: :works_authorships

  has_one :works_biblio,
          primary_key: :work_openalex_id,
          foreign_key: :work_openalex_id

  has_one :works_ids,
          primary_key: :work_openalex_id,
          foreign_key: :work_openalex_id

  has_one :works_open_access,
          primary_key: :work_openalex_id,
          foreign_key: :work_openalex_id

  has_many :works_topics
  has_many :topics, through: :works_topics

  # Below here is magic join table nonsense that will break if you touch it
  # Connects a 'work' to works that it references ('referenced_works')
  # and to works the reference the original work ('referencing_works')
  # through the WorksReferencedWorks table

  has_many :referenced_works_connections,
           primary_key: :work_openalex_id,
           foreign_key: :work_openalex_id,
           class_name: 'WorksReferencedWorks'

  has_many :referenced_works,
           through: :referenced_works_connections,
           source: :referenced_work

  has_many :referencing_works_connections,
           primary_key: :work_openalex_id,
           foreign_key: :referenced_work_openalex_id,
           class_name: 'WorksReferencedWorks'

  has_many :referencing_works,
           through: :referencing_works_connections,
           source: :referencing_work
end
