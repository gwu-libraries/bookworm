# frozen_string_literal: true

class ConceptsAncestors < ApplicationRecord

  belongs_to :concept, foreign_key: 'concept_id', class_name: 'Concept'
  belongs_to :ancestor, foreign_key: 'ancestor_id', class_name: 'Concept'

end