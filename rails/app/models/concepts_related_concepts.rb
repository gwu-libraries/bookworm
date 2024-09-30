# frozen_string_literal: true

class ConceptsRelatedConcepts < ApplicationRecord

  belongs_to :concept, foreign_key: 'concept_id', class_name: 'Concept'
  belongs_to :related_concept, foreign_key: 'related_concept_id', class_name: 'Concept'

end