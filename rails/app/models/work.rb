# frozen_string_literal: true

class Work < ApplicationRecord
  has_many :works_authorships
  has_many :authors, through: :works_authorships
  has_many :institutions, through: :works_authorships

  # these might need to be has_many
  has_one :works_biblio
  has_one :works_ids
  has_one :works_open_access
  has_one :works_mesh

  has_many :works_concepts
  has_many :concepts, through: :works_concepts

  has_many :works_topics
  has_many :topics, through: :works_topics

  # reference_connections "names" the Connection join table for accessing through the reference association
  has_many :works_related_works,
           foreign_key: :related_work_id,
           class_name: 'WorksRelatedWorks'
  # source: :reference matches with the belong_to :reference identification in the Connection model
  has_many :related_works, through: :works_related_works, source: :related_work

  # citation_connections "names" the Connection join table for accessing through the citation association
  has_many :works_referenced_works,
           foreign_key: :referenced_work_id,
           class_name: 'WorksReferencedWorks'

  # source: :citation matches with the belong_to :citation identification in the Connection model
  has_many :referenced_works,
           through: :works_referenced_works,
           source: :referenced_work
end
