# frozen_string_literal: true

class Concept < ApplicationRecord
  has_many :works_concepts
  has_many :works, through: :works_concepts
  has_one :concepts_counts_by_year
  has_one :concepts_ids

  has_many :concepts_related_concepts,
           foreign_key: :related_concept_id,
           class_name: 'ConceptsRelatedConcepts'

  has_many :related_concepts, through: :concepts_related_concepts, source: :related_concept
end
